import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import '../../../shared/theme.dart';
import '../../../utils/custom_form_input.dart';
import '../../../utils/custom_tittle_form.dart';
import '../controllers/kartu_keluarga_controller.dart';

class KartuKeluargaView extends GetView<KartuKeluargaController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Kartu Keluarga Baru'),
        backgroundColor: kPrimaryColor,
      ),
      body: Obx(
        (() => Container(
              child: Stepper(
                elevation: 1,
                type: StepperType.vertical,
                steps: formStep(),
                onStepContinue: () {
                  if (!controller
                      .formKeys[controller.currentStep.value].currentState!
                      .validate()) {
                    return;
                  }
                  if (controller.currentStep.value == formStep().length - 1) {
                    EasyLoading.show(status: 'memuat...');
                    controller.addKK();
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
                    margin: EdgeInsets.only(
                      top: 30,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: (Container(
                            height: 50,
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
                                    side:
                                        BorderSide(width: 1, color: kGreyColor),
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
              ),
            )),
      ),
    );
  }

  List<Step> formStep() {
    return [
      Step(
        title: Text(
          'Pemohon',
          style: blackTextStyle.copyWith(fontWeight: semiBold),
        ),
        content: FutureBuilder<Map<String, dynamic>?>(
            future: controller.getProfile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                EasyLoading.show(status: 'memuat...');
                EasyLoading.dismiss();
              }
              if (snapshot.data == null) {
                return Center(
                  child: Text("Tidak ada data user."),
                );
              } else {
                controller.namaLengkapPemohonC.text = snapshot.data!["nama"];
                controller.nikPemohonC.text = snapshot.data!["nik"];
                controller.noTeleponC.text = snapshot.data!["nomor_telp"];
              }
              return Form(
                key: controller.formKeys[0],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// NIK
                    CustomTitleWidget(title: 'NIK'),
                    SizedBox(height: 12.h),
                    CustomFormField(
                      readOnly: false,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      textEditingController: controller.nikPemohonC,
                    ),

                    SizedBox(height: 20.h),

                    /// Nama Lengkap
                    CustomTitleWidget(title: 'Nama Lengkap'),
                    SizedBox(height: 12.h),
                    CustomFormField(
                      textCapitalization: TextCapitalization.words,
                      readOnly: true,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      textEditingController: controller.namaLengkapPemohonC,
                    ),
                    SizedBox(height: 20.h),

                    /// No. Kk Semula
                    CustomTitleWidget(title: 'No. KK Semula'),
                    SizedBox(height: 12.h),
                    CustomFormField(
                      readOnly: false,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      textEditingController: controller.noKkSemula,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Input tidak boleh kosong";
                        } else if (!GetUtils.isLengthEqualTo(value, 16)) {
                          return 'NIK harus 16 karakter';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),

                    /// Kabupaten/Kota
                    CustomTitleWidget(title: 'Kabupaten/Kota'),
                    SizedBox(height: 12.h),
                    CustomFormField(
                      readOnly: false,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      textEditingController: controller.kabupatenKotaC,
                      onTap: () {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Masukan nama kabupaten/kota";
                        } else {
                          return null;
                        }
                      },
                      textCapitalization: TextCapitalization.words,
                    ),

                    SizedBox(height: 20.h),

                    /// Provinsi
                    CustomTitleWidget(title: 'Provinsi'),
                    SizedBox(height: 12.h),
                    CustomFormField(
                      readOnly: false,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      textEditingController: controller.provinsiC,
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

                    /// Kecamatan
                    CustomTitleWidget(title: 'Kecamatan'),
                    SizedBox(height: 12.h),
                    CustomFormField(
                      readOnly: false,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      textEditingController: controller.kecamatanC,
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

                    /// Desa
                    CustomTitleWidget(title: 'Desa'),
                    SizedBox(height: 12.h),
                    CustomFormField(
                      readOnly: false,
                      textInputAction: TextInputAction.next,
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

                    /// RT
                    CustomTitleWidget(title: 'RT'),
                    SizedBox(height: 12.h),
                    CustomFormField(
                      readOnly: false,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      textEditingController: controller.rtC,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Input tidak boleh kosong";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 20.h),

                    /// RW
                    CustomTitleWidget(title: 'RW'),
                    SizedBox(height: 12.h),
                    CustomFormField(
                      readOnly: false,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      textEditingController: controller.rwC,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Input tidak boleh kosong";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 20.h),

                    /// Kode Pos
                    CustomTitleWidget(title: 'Kode Pos'),
                    SizedBox(height: 12.h),
                    CustomFormField(
                      readOnly: false,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      textEditingController: controller.kodePosC,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Input tidak boleh kosong";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 20.h),

                    /// Jumlah Anggota Keluarga
                    CustomTitleWidget(title: 'Jml Anggota Keluarga'),
                    SizedBox(height: 12.h),
                    CustomFormField(
                      readOnly: false,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      textEditingController: controller.jmlAnggotaFamylyC,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Input tidak boleh kosong";
                        } else {
                          return null;
                        }
                      },
                    ),

                    SizedBox(height: 20.h),

                    /// No. Telepon
                    CustomTitleWidget(title: 'No. Telepon'),
                    SizedBox(height: 12.h),
                    CustomFormField(
                      textCapitalization: TextCapitalization.none,
                      readOnly: true,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      textEditingController: controller.noTeleponC,
                    ),
                    SizedBox(height: 20.h),

                    /// Alasan Permohonnan
                    CustomTitleWidget(title: 'Alasan Permohonan'),
                    SizedBox(height: 12.h),
                    DropdownSearch<Map<String, dynamic>>(
                      dialogMaxWidth: 8,
                      mode: Mode.MENU,
                      items: controller.alasanPermohonan,
                      dropdownButtonSplashRadius: 10,
                      dropdownBuilder: (context, selectedItem) => Text(
                        selectedItem?["alasanP"].toString() ?? "PILIH",
                        style: blackTextStyle,
                      ),
                      popupItemBuilder: (context, item, isSelected) => ListTile(
                        title: Text(
                          item["alasanP"].toString(),
                          style: blackTextStyle,
                        ),
                      ),
                      showClearButton: true,
                      onChanged: (value) {
                        print(value!["alasanP"]);
                        controller.alasanPermohonanC =
                            TextEditingController(text: value["alasanP"]);
                      },
                    ),
                  ],
                ),
              );
            }),
        isActive: controller.currentStep.value >= 0,
        state:
            controller.currentStep > 0 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: Text('Daftar Anggota Keluarga',
            style: blackTextStyle.copyWith(fontWeight: semiBold)),
        content: Form(
            key: controller.formKeys[1],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// NIK
                CustomTitleWidget(title: 'NIK Anggota 1 (Satu)'),
                SizedBox(height: 12.h),
                CustomFormField(
                  readOnly: false,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  textEditingController: controller.nikAnggota1,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Input tidak boleh kosong";
                    } else if (!GetUtils.isLengthEqualTo(value, 16)) {
                      return 'NIK harus 16 karakter';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20.h),

                /// Nama Lengkap
                CustomTitleWidget(title: 'Nama Lengkap Anggota 1 (Satu)'),
                SizedBox(height: 12.h),
                CustomFormField(
                    textCapitalization: TextCapitalization.words,
                    readOnly: false,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Input tidak boleh kosong";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.name,
                    textEditingController: controller.namaAnggota1),
                SizedBox(height: 20.h),

                /// NIK
                CustomTitleWidget(title: 'NIK Anggota 2 (Dua)'),
                SizedBox(height: 12.h),
                CustomFormField(
                  readOnly: false,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Input tidak boleh kosong";
                    } else if (!GetUtils.isLengthEqualTo(value, 16)) {
                      return 'NIK harus 16 karakter';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  textEditingController: controller.nikAnggota2,
                ),

                SizedBox(height: 20.h),

                /// Nama Lengkap
                CustomTitleWidget(title: 'Nama Lengkap Anggota 2 (Dua)'),
                SizedBox(height: 12.h),
                CustomFormField(
                    textCapitalization: TextCapitalization.words,
                    readOnly: false,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Input tidak boleh kosong";
                      } else {
                        return null;
                      }
                    },
                    textEditingController: controller.namaAnggota2),
                SizedBox(height: 20.h),

                /// NIK
                CustomTitleWidget(title: 'NIK Anggota 3 (Tiga)'),
                SizedBox(height: 12.h),
                CustomFormField(
                  readOnly: false,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  textEditingController: controller.nikAnggota3,
                ),

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

                /// NIK
                CustomTitleWidget(title: 'NIK Anggota 4 (Empat)'),
                SizedBox(height: 12.h),
                CustomFormField(
                  readOnly: false,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  textEditingController: controller.nikAnggota4,
                ),

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

                /// NIK
                CustomTitleWidget(title: 'NIK Anggota 5 (Lima)'),
                SizedBox(height: 12.h),
                CustomFormField(
                  readOnly: false,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  textEditingController: controller.nikAnggota5,
                ),

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

                /// NIK
                CustomTitleWidget(title: 'NIK Anggota 6 (Enam)'),
                SizedBox(height: 12.h),
                CustomFormField(
                  readOnly: false,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  textEditingController: controller.nikAnggota5,
                ),

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
          'Unggah Persyaratan',
          style: blackTextStyle.copyWith(fontWeight: semiBold),
        ),
        content: Form(
          key: controller.formKeys[2],
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// KK
                Text(
                  'Unggah KK lama',
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
                        GetBuilder<KartuKeluargaController>(
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
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                              child: Container(
                                width: 120.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: GetBuilder<KartuKeluargaController>(
                                  builder: (c) {
                                    return c.pickedImageKK != null
                                        ? ElevatedButton(
                                            onPressed: () {
                                              Get.dialog(
                                                Container(
                                                  child: PhotoView(
                                                    imageProvider: FileImage(
                                                      File(c
                                                          .pickedImageKK!.path),
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

                SizedBox(height: 20.h),

                ///BUKU NIKAH/AKTA PERKAWINAN
                Text(
                  'Unggah Buku Nikah/Akta Perkawinan',
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
                        GetBuilder<KartuKeluargaController>(
                          builder: (c) => c.pickedImageAktaPerkawinan != null
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        c.pickedImageAktaPerkawinan!.name,
                                        style: blackTextStyle.copyWith(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          c.resetImageAktaPerkawinan(),
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
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                              child: Container(
                                width: 120.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: GetBuilder<KartuKeluargaController>(
                                  builder: (c) {
                                    return c.pickedImageAktaPerkawinan != null
                                        ? ElevatedButton(
                                            onPressed: () {
                                              Get.dialog(
                                                Container(
                                                  child: PhotoView(
                                                    imageProvider: FileImage(
                                                      File(c
                                                          .pickedImageAktaPerkawinan!
                                                          .path),
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
                            ),
                            Container(
                              width: 120.w,
                              height: 40.h,
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.selectImageAktaPerkawinan();
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

                SizedBox(height: 20.h),

                ///SUKET DOMISILI
                Text(
                  'Surat Keterangan Domisili',
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
                        GetBuilder<KartuKeluargaController>(
                          builder: (c) => c.pickedImageSuketDomisili != null
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        c.pickedImageSuketDomisili!.name,
                                        style: blackTextStyle.copyWith(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          c.resetImageSuketDomisli(),
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
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                              child: Container(
                                width: 120.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: GetBuilder<KartuKeluargaController>(
                                  builder: (c) {
                                    return c.pickedImageSuketDomisili != null
                                        ? ElevatedButton(
                                            onPressed: () {
                                              Get.dialog(
                                                Container(
                                                  child: PhotoView(
                                                    imageProvider: FileImage(
                                                      File(c
                                                          .pickedImageSuketDomisili!
                                                          .path),
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
                            ),
                            Container(
                              width: 120.w,
                              height: 40.h,
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.selectImageSuketDomisili();
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
        ),
        isActive: controller.currentStep.value >= 2,
      ),
    ];
  }
}
