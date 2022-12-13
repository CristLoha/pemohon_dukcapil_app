import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import '../../../shared/theme.dart';
import '../../../utils/custom_date_input.dart';
import '../../../utils/custom_form_input.dart';
import '../../../utils/custom_input_keterangan.dart';
import '../../../utils/custom_tittle_form.dart';
import '../controllers/surat_keterangan_pindah_controller.dart';

class SuratKeteranganPindahView
    extends GetView<SuratKeteranganPindahController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Permohonan Pindah Datang'),
        backgroundColor: kPrimaryColor,
      ),
      body: Obx(
        (() => Stepper(
              elevation: 1,
              type: StepperType.vertical,
              steps: formStep(),
              onStepContinue: () {
                if (!controller.formKeys[controller.index].currentState!
                    .validate()) {
                  return;
                }
                if (controller.currentStep.value == formStep().length - 1) {
                  EasyLoading.show(status: 'memuat...');
                  controller.addrekamanKTP();
                } else {
                  controller.currentStep.value++;
                }
              },
              onStepCancel: () {
                controller.currentStep.value == 0
                    ? null
                    : controller.currentStep.value--;
              },
              onStepTapped: (index) {
                controller.currentStep.value = index;
              },
              currentStep: controller.currentStep.value,
              controlsBuilder: (context, details) {
                return Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: (Container(
                          height: 50,
                          margin: EdgeInsets.only(top: 40),
                          child: ElevatedButton(
                            onPressed: details.onStepContinue,
                            child: Text(
                              controller.currentStep.value ==
                                      formStep().length - 1
                                  ? "Kirim"
                                  : 'Selanjutnya',
                              style: whiteTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: medium,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: kPrimaryColor,
                            ),
                          ),
                        )),
                      ),
                      SizedBox(width: 12),
                      if (controller.currentStep.value != 0)
                        Expanded(
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.only(top: 40),
                            child: (Container(
                              child: ElevatedButton(
                                onPressed: details.onStepCancel,
                                child: Text(
                                  'Kembali',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: medium,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  side: BorderSide(width: 1, color: kGreyColor),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  backgroundColor: kWhiteColor,
                                ),
                              ),
                            )),
                          ),
                        ),
                    ],
                  ),
                );
              },
            )),
      ),
    );
  }

  List<Step> formStep() {
    return [
      Step(
        title: Text('Daerah Asal',
            style: blackTextStyle.copyWith(fontWeight: semiBold)),
        content: Form(
            key: controller.formKeys[0],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Nomor KK
                CustomTitleWidget(title: 'Nomor KK'),
                SizedBox(height: 12.h),
                CustomFormField(
                  readOnly: false,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Input tidak boleh kosong";
                    } else if (!GetUtils.isLengthEqualTo(value, 16)) {
                      return 'NO. KK harus 16 karakter';
                    }
                    return null;
                  },
                  textEditingController: controller.noKKC,
                  textCapitalization: TextCapitalization.none,
                ),
                SizedBox(height: 20.h),

                /// Nama Kepala Keluarga
                CustomTitleWidget(title: 'Nama Kepala Keluarga'),
                SizedBox(height: 12.h),
                CustomFormField(
                  readOnly: false,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  textEditingController: controller.namaKepalaKeluargaC,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Input tidak boleh kosong";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20.h),

                /// NAMA
                CustomTitleWidget(title: 'Nama Lengkap'),
                SizedBox(height: 12.h),
                CustomFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Input tidak boleh kosong";
                    } else {
                      return null;
                    }
                  },
                  readOnly: true,
                  textEditingController: controller.nameC,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                ),
                SizedBox(height: 20.h),
              ],
            )),

        ///
        isActive: controller.currentStep.value >= 0,
        state:
            controller.currentStep > 0 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: Text('Alamat Tujuan',
            style: blackTextStyle.copyWith(fontWeight: semiBold)),
        content: Form(
            key: controller.formKeys[1],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Nama Lengkap
                CustomTitleWidget(title: 'Nama Lengkap Anggota 1 (Satu)'),
                SizedBox(height: 12.h),
                CustomFormField(
                    textCapitalization: TextCapitalization.words,
                    readOnly: false,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    textEditingController: controller.namaAnggota1),
                SizedBox(height: 20.h),

                /// Nama Lengkap
                CustomTitleWidget(title: 'Nama Lengkap Anggota 2 (Dua)'),
                SizedBox(height: 12.h),
                CustomFormField(
                    textCapitalization: TextCapitalization.words,
                    readOnly: false,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    textEditingController: controller.namaAnggota2),
                SizedBox(height: 20.h),
              ],
            )),

        ///
        isActive: controller.currentStep.value >= 1,
        state:
            controller.currentStep > 1 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: Text(
          'Pemohon',
          style: blackTextStyle.copyWith(fontWeight: semiBold),
        ),
        content: FutureBuilder<Map<String, dynamic>?>(
            future: controller.getProfile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data == null) {
                return Center(
                  child: Text("Tidak ada data user."),
                );
              } else {
                controller.namaPemohonC.text = snapshot.data!["nama"];
                controller.noTelpC.text = snapshot.data!["nomor_telp"];
                controller.nikPemohonC.text = snapshot.data!["nik"];

                return Form(
                  key: controller.formKeys[2],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// NIK
                      CustomTitleWidget(title: 'NIK'),
                      SizedBox(height: 12.h),
                      CustomFormField(
                        readOnly: false,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        textEditingController: controller.nikC,
                        textCapitalization: TextCapitalization.none,
                      ),
                      SizedBox(height: 20.h),

                      /// KK
                      CustomTitleWidget(title: 'KK'),
                      SizedBox(height: 12.h),
                      CustomFormField(
                        readOnly: false,
                        textCapitalization: TextCapitalization.none,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        textEditingController: controller.noKKC,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Input tidak boleh kosong";
                          } else if (!GetUtils.isLengthEqualTo(value, 16)) {
                            return 'NO. KK harus 16 karakter';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),

                      /// NAMA
                      CustomTitleWidget(title: 'Nama Lengkap'),
                      SizedBox(height: 12.h),
                      CustomFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Input tidak boleh kosong";
                          } else {
                            return null;
                          }
                        },
                        readOnly: true,
                        textEditingController: controller.nameC,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                      ),

                      SizedBox(height: 20.h),

                      /// Nomor Telepon
                      CustomTitleWidget(title: 'Nomor Telepon'),
                      SizedBox(height: 12.h),
                      CustomFormField(
                        readOnly: false,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        textEditingController: controller.noTelpC,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Input tidak boleh kosong";
                          } else {
                            return null;
                          }
                        },
                        textCapitalization: TextCapitalization.none,
                      ),
                      SizedBox(height: 20.h),

                      /// PROVINSI TUJUAN
                      CustomTitleWidget(title: 'Provinsi Tujuan'),
                      SizedBox(height: 12.h),
                      CustomFormField(
                        readOnly: false,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.name,
                        textEditingController: controller.provinsiTujuan,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Input tidak boleh kosong";
                          } else {
                            return null;
                          }
                        },
                        textCapitalization: TextCapitalization.words,
                      ),

                      SizedBox(height: 20),

                      /// KABUPATEN/KOTA TUJUAN
                      CustomTitleWidget(title: 'Kabupate/Kota Tujuan'),
                      SizedBox(height: 12.h),
                      CustomFormField(
                        readOnly: false,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        textEditingController: controller.kabupatenKotaTujuan,
                        onTap: () {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Input tidak boleh kosong";
                          } else {
                            return null;
                          }
                        },
                        textCapitalization: TextCapitalization.words,
                      ),

                      SizedBox(height: 20.h),

                      /// KECAMATAN TUJUAN
                      CustomTitleWidget(title: 'Kecamatan Tujuan'),
                      SizedBox(height: 12.h),
                      CustomFormField(
                        readOnly: false,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.name,
                        textEditingController: controller.kecamatanTujuan,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Input tidak boleh kosong";
                          } else {
                            return null;
                          }
                        },
                        textCapitalization: TextCapitalization.words,
                      ),
                      SizedBox(height: 20.h),

                      /// DESA/KELURAHAN TUJUAN
                      CustomTitleWidget(title: 'Desa/Kelurahan Tujuan'),
                      SizedBox(height: 12.h),
                      CustomFormField(
                        readOnly: false,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.name,
                        textEditingController: controller.desaC,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Input tidak boleh kosong";
                          } else {
                            return null;
                          }
                        },
                        textCapitalization: TextCapitalization.words,
                      ),
                      SizedBox(height: 20.h),

                      ///ALAMAT TUJUAN

                      CustomTitleWidget(title: 'Alamat Tujuan'),
                      SizedBox(height: 12.h),
                      CustomFormField(
                        readOnly: false,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.name,
                        textEditingController: controller.alamatTujuan,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Input tidak boleh kosong";
                          } else {
                            return null;
                          }
                        },
                        textCapitalization: TextCapitalization.words,
                      ),
                      SizedBox(height: 20.h),

                      ///RT

                      CustomTitleWidget(title: 'RT'),
                      SizedBox(height: 12.h),
                      CustomFormField(
                        readOnly: false,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.name,
                        textEditingController: controller.rtC,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Input tidak boleh kosong";
                          } else {
                            return null;
                          }
                        },
                        textCapitalization: TextCapitalization.words,
                      ),
                      SizedBox(height: 20.h),

                      ///RW
                      CustomTitleWidget(title: 'RW'),
                      SizedBox(height: 12.h),
                      CustomFormField(
                        readOnly: false,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.name,
                        textEditingController: controller.rwC,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Input tidak boleh kosong";
                          } else {
                            return null;
                          }
                        },
                        textCapitalization: TextCapitalization.words,
                      ),
                      SizedBox(height: 20.h),

                      ///STATUS NO. KK BAGI YANG PINDAH

                      CustomTitleWidget(title: 'Sttus NO. KK bagi yang pindah'),
                      SizedBox(height: 12.h),
                      DropdownSearch<Map<String, dynamic>>(
                        dialogMaxWidth: 8,
                        mode: Mode.MENU,
                        items: controller.statusNoKKbagiyangPindah,
                        dropdownButtonSplashRadius: 10,
                        dropdownBuilder: (context, selectedItem) => Text(
                          selectedItem?["statusKK"].toString() ?? "PILIH",
                          style: blackTextStyle,
                        ),
                        popupItemBuilder: (context, item, isSelected) =>
                            ListTile(
                          title: Text(
                            item["statusKK"].toString(),
                            style: blackTextStyle,
                          ),
                        ),
                        showClearButton: true,
                        onChanged: (value) {
                          print(value!["statusKK"]);
                          controller.statusNoKK =
                              TextEditingController(text: value["statusKK"]);
                        },
                      ),
                      SizedBox(height: 20.h),

                      ///Keterangan
                      CustomTitleWidget(title: 'Alasan Pindah'),
                      SizedBox(height: 12.h),
                      CustomFormKeteranganField(
                        readOnly: false,
                        textInputAction: TextInputAction.done,
                        textEditingController: controller.keteranganC,
                      ),
                    ],
                  ),
                );
              }
            }),
        isActive: controller.currentStep.value >= 2,
        state:
            controller.currentStep > 2 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: Text('Daftar Anggota Keluarga',
            style: blackTextStyle.copyWith(fontWeight: semiBold)),
        content: Form(
            key: controller.formKeys[3],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Nama Lengkap
                CustomTitleWidget(title: 'Nama Lengkap Anggota 1 (Satu)'),
                SizedBox(height: 12.h),
                CustomFormField(
                    textCapitalization: TextCapitalization.words,
                    readOnly: false,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    textEditingController: controller.namaAnggota1),
                SizedBox(height: 20.h),

                /// Nama Lengkap
                CustomTitleWidget(title: 'Nama Lengkap Anggota 2 (Dua)'),
                SizedBox(height: 12.h),
                CustomFormField(
                    textCapitalization: TextCapitalization.words,
                    readOnly: false,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    textEditingController: controller.namaAnggota2),
                SizedBox(height: 20.h),

                /// Nama Lengkap
                CustomTitleWidget(title: 'Nama Lengkap Anggota 3 (Tiga)'),
                SizedBox(height: 12.h),
                CustomFormField(
                    textCapitalization: TextCapitalization.words,
                    readOnly: false,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    textEditingController: controller.namaAnggota3),
                SizedBox(height: 20.h),

                /// Nama Lengkap
                CustomTitleWidget(title: 'Nama Lengkap Anggota 4 (Empat)'),
                SizedBox(height: 12.h),
                CustomFormField(
                    textCapitalization: TextCapitalization.words,
                    readOnly: false,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    textEditingController: controller.namaAnggota4),
                SizedBox(height: 20.h),

                /// Nama Lengkap
                CustomTitleWidget(title: 'Nama Lengkap Anggota 5 (Lima)'),
                SizedBox(height: 12.h),
                CustomFormField(
                    textCapitalization: TextCapitalization.words,
                    readOnly: false,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    textEditingController: controller.namaAnggota5),
                SizedBox(height: 20.h),

                /// Nama Lengkap
                CustomTitleWidget(title: 'Nama Lengkap Anggota 6 (Enam)'),
                SizedBox(height: 12.h),
                CustomFormField(
                    textCapitalization: TextCapitalization.words,
                    readOnly: false,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    textEditingController: controller.namaAnggota6),
              ],
            )),

        ///
        isActive: controller.currentStep.value >= 3,
        state:
            controller.currentStep > 3 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: Text('Persyaratan',
            style: blackTextStyle.copyWith(fontWeight: semiBold)),
        content: Form(
          key: controller.formKeys[4],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///KK
              Text(
                'Unggah KK',
                style: blackTextStyle.copyWith(),
              ),
              SizedBox(height: 12.h),
              Center(
                child: Container(
                  padding: EdgeInsets.only(left: 15, top: 20, right: 10),
                  width: 315.w,
                  height: 140.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: kGreyColor,
                    ),
                  ),
                  child: Column(
                    children: [
                      GetBuilder<SuratKeteranganPindahController>(
                        builder: (c) => c.pickedImageKK != null
                            ? Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      c.pickedImageKK!.name,
                                      style: blackTextStyle.copyWith(),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => c.resetImageKK(),
                                    child: Icon(
                                      Icons.delete,
                                      color: kRedColor,
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                '*Maks 5 Mb',
                                style: redTextStyle.copyWith(),
                              ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 120.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: GetBuilder<SuratKeteranganPindahController>(
                              builder: (c) {
                                return c.pickedImageKK != null
                                    ? ElevatedButton(
                                        onPressed: () {
                                          Get.dialog(
                                            Container(
                                              child: PhotoView(
                                                imageProvider: FileImage(
                                                  File(c.pickedImageKK!.path),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'Lihat',
                                          style: blackTextStyle.copyWith(
                                            fontSize: 16.sp,
                                            fontWeight: medium,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            side: BorderSide(
                                              color: kGreyColor,
                                            ),
                                          ),
                                          backgroundColor: kWhiteColor,
                                        ),
                                      )
                                    : ElevatedButton(
                                        onPressed: () {
                                          EasyLoading.showError(
                                            'Masukan file terlebihi dahulu',
                                          );
                                        },
                                        child: Text(
                                          'Lihat',
                                          style: blackTextStyle.copyWith(
                                            fontSize: 16.sp,
                                            fontWeight: medium,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            side: BorderSide(
                                              color: kGreyColor,
                                            ),
                                          ),
                                          backgroundColor: kWhiteColor,
                                        ));
                              },
                            ),
                          ),
                          Container(
                            width: 120.w,
                            height: 40.h,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.selectImageKK();
                              },
                              child: Text(
                                'Pilih File',
                                style: blackTextStyle.copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: medium,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  side: BorderSide(
                                    color: kGreyColor,
                                  ),
                                ),
                                backgroundColor: kWhiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              ///KTP
              Text(
                'Unggah KTP',
                style: blackTextStyle.copyWith(),
              ),
              SizedBox(height: 12.h),
              Center(
                child: Container(
                  padding: EdgeInsets.only(left: 15, top: 20, right: 10),
                  width: 315.w,
                  height: 140.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: kGreyColor,
                    ),
                  ),
                  child: Column(
                    children: [
                      GetBuilder<SuratKeteranganPindahController>(
                        builder: (c) => c.pickedImageKTP != null
                            ? Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      c.pickedImageKTP!.name,
                                      style: blackTextStyle.copyWith(),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => c.resetImageKTP(),
                                    child: Icon(
                                      Icons.delete,
                                      color: kRedColor,
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                '*Maks 5 Mb',
                                style: redTextStyle.copyWith(),
                              ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 120.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: GetBuilder<SuratKeteranganPindahController>(
                              builder: (c) {
                                return c.pickedImageKTP != null
                                    ? ElevatedButton(
                                        onPressed: () {
                                          Get.dialog(
                                            Container(
                                              child: PhotoView(
                                                imageProvider: FileImage(
                                                  File(c.pickedImageKTP!.path),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'Lihat',
                                          style: blackTextStyle.copyWith(
                                            fontSize: 16.sp,
                                            fontWeight: medium,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            side: BorderSide(
                                              color: kGreyColor,
                                            ),
                                          ),
                                          backgroundColor: kWhiteColor,
                                        ),
                                      )
                                    : ElevatedButton(
                                        onPressed: () {
                                          EasyLoading.showError(
                                            'Masukan file terlebihi dahulu',
                                          );
                                        },
                                        child: Text(
                                          'Lihat',
                                          style: blackTextStyle.copyWith(
                                            fontSize: 16.sp,
                                            fontWeight: medium,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            side: BorderSide(
                                              color: kGreyColor,
                                            ),
                                          ),
                                          backgroundColor: kWhiteColor,
                                        ));
                              },
                            ),
                          ),
                          Container(
                            width: 120.w,
                            height: 40.h,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.selectImageKTP();
                              },
                              child: Text(
                                'Pilih File',
                                style: blackTextStyle.copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: medium,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  side: BorderSide(
                                    color: kGreyColor,
                                  ),
                                ),
                                backgroundColor: kWhiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        isActive: controller.currentStep.value >= 4,
      ),
    ];
  }
}
