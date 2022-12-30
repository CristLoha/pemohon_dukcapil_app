import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pemohon_dukcapil_app/app/utils/custom_date_input.dart';
import 'package:photo_view/photo_view.dart';
import '../../../shared/theme.dart';
import '../../../utils/custom_form_input.dart';
import '../../../utils/custom_tittle_form.dart';
import '../controllers/akta_nikah_controller.dart';

class AktaNikahView extends GetView<AktaNikahController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Akta Nikah'),
        backgroundColor: kPrimaryColor,
      ),
      body: Obx(
        (() => Stepper(
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
                  controller.addAktaNikah();
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
        title: Text(
          'Suami',
          style: blackTextStyle.copyWith(fontWeight: semiBold),
        ),
        content: Form(
          key: controller.formKeys[0],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// NIK SUAMI
              CustomTitleWidget(title: 'NIK'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textEditingController: controller.nikSuamiC,
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

              /// Nama Lengkap Suami
              CustomTitleWidget(title: 'Nama Lengkap'),
              SizedBox(height: 12.h),
              CustomFormField(
                  textCapitalization: TextCapitalization.words,
                  readOnly: false,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  textEditingController: controller.namaLengkapSuamiC),

              /// Tanggal Lahir suami
              SizedBox(height: 20.h),
              CustomTitleWidget(title: 'Tanggal lahir'),
              SizedBox(height: 12.h),
              CustomDateInput(
                onTap: () => controller.tglLahirSuami(),
                controller: controller.tanggalLahirSuamiC,
              ),
              SizedBox(height: 20.h),

              /// Tempat Lahir Suami
              CustomTitleWidget(title: 'Tempat Lahir'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                textEditingController: controller.tempatLahirSuamiC,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Input tidak boleh kosong";
                  } else {
                    return null;
                  }
                },
                textCapitalization: TextCapitalization.words,
              ),

              /// Anak Ke
              SizedBox(height: 20.h),
              CustomTitleWidget(title: 'Anak Ke-'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textEditingController: controller.anakKeSuamiC,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Input tidak boleh kosong";
                  } else {
                    return null;
                  }
                },
                textCapitalization: TextCapitalization.none,
              ),

              /// Kewarganegaraan Suami
              SizedBox(height: 20.h),
              CustomTitleWidget(title: 'Kewarganegaraan'),
              SizedBox(height: 12.h),
              DropdownSearch<Map<String, dynamic>>(
                dialogMaxWidth: 8,
                mode: Mode.MENU,
                items: controller.dataJenisKewarganegaraan,
                dropdownButtonSplashRadius: 10,
                dropdownBuilder: (context, selectedItem) => Text(
                  selectedItem?["jenisK"].toString() ?? "PILIH",
                  style: blackTextStyle,
                ),
                popupItemBuilder: (context, item, isSelected) => ListTile(
                  title: Text(
                    item["jenisK"].toString(),
                    style: blackTextStyle,
                  ),
                ),
                showClearButton: true,
                onChanged: (value) {
                  print(value!["jenisK"]);
                  controller.kewarganegaraanSuamiC =
                      TextEditingController(text: value["jenisK"]);
                },
              ),
            ],
          ),
        ),
        isActive: controller.currentStep.value >= 0,
        state:
            controller.currentStep > 0 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: Text(
          'Istri',
          style: blackTextStyle.copyWith(fontWeight: semiBold),
        ),
        content: Form(
          key: controller.formKeys[1],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// NIK SUAMI
              CustomTitleWidget(title: 'NIK'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textEditingController: controller.nikIstriC,
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
              CustomTitleWidget(title: 'Nama Lengkap'),
              SizedBox(height: 12.h),
              CustomFormField(
                  textCapitalization: TextCapitalization.words,
                  readOnly: false,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  textEditingController: controller.namaLengkapIstriC),

              /// Tanggal Lahir
              SizedBox(height: 20.h),
              CustomTitleWidget(title: 'Tanggal lahir'),
              SizedBox(height: 12.h),
              CustomDateInput(
                onTap: () => controller.tglLahirIstri(),
                controller: controller.tanggalLahirIstriC,
              ),

              /// Tempat Lahir
              SizedBox(height: 20.h),
              CustomTitleWidget(title: 'Tempat Lahir'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                textEditingController: controller.tempatLahirIstriC,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Input tidak boleh kosong";
                  } else {
                    return null;
                  }
                },
                textCapitalization: TextCapitalization.words,
              ),

              /// Anak Ke
              SizedBox(height: 20.h),
              CustomTitleWidget(title: 'Anak Ke-'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textEditingController: controller.anakKeIstriC,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Input tidak boleh kosong";
                  } else {
                    return null;
                  }
                },
                textCapitalization: TextCapitalization.none,
              ),

              /// Kewarganegaraan
              SizedBox(height: 20.h),
              CustomTitleWidget(title: 'Kewarganegaraan'),
              SizedBox(height: 12.h),
              DropdownSearch<Map<String, dynamic>>(
                dialogMaxWidth: 8,
                mode: Mode.MENU,
                items: controller.dataJenisKewarganegaraan,
                dropdownButtonSplashRadius: 10,
                dropdownBuilder: (context, selectedItem) => Text(
                  selectedItem?["jenisK"].toString() ?? "PILIH",
                  style: blackTextStyle,
                ),
                popupItemBuilder: (context, item, isSelected) => ListTile(
                  title: Text(
                    item["jenisK"].toString(),
                    style: blackTextStyle,
                  ),
                ),
                showClearButton: true,
                onChanged: (value) {
                  print(value!["jenisK"]);
                  controller.kewarganegaraanIstriC =
                      TextEditingController(text: value["jenisK"]);
                },
              ),
            ],
          ),
        ),
        isActive: controller.currentStep.value >= 1,
        state:
            controller.currentStep > 1 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: Text(
          'Orang Tua Dari Suami',
          style: blackTextStyle.copyWith(fontWeight: semiBold),
        ),
        content: Form(
          key: controller.formKeys[2],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// NIK
              CustomTitleWidget(title: 'NIK Ayah'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textEditingController: controller.nikAyahDariSuami,
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
              CustomTitleWidget(title: 'Nama Lengkap Ayah'),
              SizedBox(height: 12.h),
              CustomFormField(
                  textCapitalization: TextCapitalization.words,
                  readOnly: false,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  textEditingController: controller.namaLengkapIstriC),

              /// NIK
              CustomTitleWidget(title: 'NIK Ibu'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textEditingController: controller.nikIbuDariSuami,
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
              CustomTitleWidget(title: 'Nama Lengkap Ibu'),
              SizedBox(height: 12.h),
              CustomFormField(
                  textCapitalization: TextCapitalization.words,
                  readOnly: false,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  textEditingController: controller.namaIbuDariSuami),
            ],
          ),
        ),
        isActive: controller.currentStep.value >= 2,
        state:
            controller.currentStep > 2 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: Text(
          'Orang Tua Dari Istri',
          style: blackTextStyle.copyWith(fontWeight: semiBold),
        ),
        content: Form(
          key: controller.formKeys[3],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// NIK
              CustomTitleWidget(title: 'NIK Ayah'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textEditingController: controller.nikAyahDariIstri,
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
              CustomTitleWidget(title: 'Nama Lengkap Ayah'),
              SizedBox(height: 12.h),
              CustomFormField(
                  textCapitalization: TextCapitalization.words,
                  readOnly: false,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  textEditingController: controller.namaAyahDariIstri),

              /// NIK
              CustomTitleWidget(title: 'NIK Ibu'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textEditingController: controller.nikIbuDariIstri,
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
              CustomTitleWidget(title: 'Nama Lengkap Ibu'),
              SizedBox(height: 12.h),
              CustomFormField(
                  textCapitalization: TextCapitalization.words,
                  readOnly: false,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  textEditingController: controller.namaIbuDariIstri),
            ],
          ),
        ),
        isActive: controller.currentStep.value >= 3,
        state:
            controller.currentStep > 3 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: Text(
          'Saksi',
          style: blackTextStyle.copyWith(fontWeight: semiBold),
        ),
        content: Form(
          key: controller.formKeys[4],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// NIK
              CustomTitleWidget(title: 'NIK Saksi 1'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textEditingController: controller.nikSaksi1,
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
              CustomTitleWidget(title: 'Nama Lengkap Saksi 1'),
              SizedBox(height: 12.h),
              CustomFormField(
                  textCapitalization: TextCapitalization.words,
                  readOnly: false,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  textEditingController: controller.namaLengkapSaksi1),

              /// NIK
              SizedBox(height: 20.h),
              CustomTitleWidget(title: 'NIK Saksi 2'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textEditingController: controller.nikSaksi2,
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
              CustomTitleWidget(title: 'Nama Lengkap Saksi 2'),
              SizedBox(height: 12.h),
              CustomFormField(
                  textCapitalization: TextCapitalization.words,
                  readOnly: false,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  textEditingController: controller.namaLengkapSaksi2),
            ],
          ),
        ),
        isActive: controller.currentStep.value >= 4,
        state:
            controller.currentStep > 4 ? StepState.complete : StepState.indexed,
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
                EasyLoading.show(status: 'memuat...');
                EasyLoading.dismiss();
              }
              if (snapshot.data == null) {
                return Center(
                  child: Text("Tidak ada data user."),
                );
              } else {
                controller.namaPemohonC.text = snapshot.data!["nama"];
                controller.nikPemohon.text = snapshot.data!["nik"];
                controller.noTelponPemohonC.text = snapshot.data!["nomor_telp"];
                return Form(
                  key: controller.formKeys[5],
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
                        textEditingController: controller.nikPemohon,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Input tidak boleh kosong";
                          } else if (!GetUtils.isLengthEqualTo(value, 16)) {
                            return 'No. KK harus 16 karakter';
                          }
                          return null;
                        },
                        textCapitalization: TextCapitalization.none,
                      ),
                      SizedBox(height: 20.h),

                      /// Nama Lengkap Pemohon
                      CustomTitleWidget(title: 'Nama Lengkap'),
                      SizedBox(height: 12.h),
                      CustomFormField(
                        readOnly: false,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        textEditingController: controller.namaPemohonC,
                        onTap: () {},
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                            return "Masukan nama kecamatan yang benar";
                          } else {
                            return null;
                          }
                        },
                        textCapitalization: TextCapitalization.words,
                      ),

                      SizedBox(height: 20.h),

                      /// Nomor Telepon
                      CustomTitleWidget(title: 'Nomor Telepon'),
                      SizedBox(height: 12.h),
                      CustomFormField(
                        readOnly: true,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        textEditingController: controller.noTelponPemohonC,
                        textCapitalization: TextCapitalization.none,
                      ),

                      SizedBox(height: 20),
                      CustomTitleWidget(title: 'Kecamatan'),
                      SizedBox(height: 12.h),
                      CustomFormField(
                        readOnly: false,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        textEditingController: controller.kecamatanPemohonC,
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

                      SizedBox(height: 20),
                      CustomTitleWidget(title: 'Desa/Kelurahan'),
                      SizedBox(height: 12.h),
                      CustomFormField(
                        readOnly: false,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        textEditingController: controller.desaPemohonC,
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
                    ],
                  ),
                );
              }
            }),
        isActive: controller.currentStep.value >= 5,
        state:
            controller.currentStep > 5 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: Text('Persyaratan',
            style: blackTextStyle.copyWith(fontWeight: semiBold)),
        content: Form(
          key: controller.formKeys[6],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// SELFIE PELAPOR
              Text(
                'Unggah Selfie Pemohon',
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
                      GetBuilder<AktaNikahController>(
                        builder: (c) => c.pickedImageSelfie != null
                            ? Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      c.pickedImageSelfie!.name,
                                      style: blackTextStyle.copyWith(),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => c.resetImageSelfie(),
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
                            child: GetBuilder<AktaNikahController>(
                              builder: (c) {
                                return c.pickedImageSelfie != null
                                    ? ElevatedButton(
                                        onPressed: () {
                                          Get.dialog(
                                            Container(
                                              child: PhotoView(
                                                imageProvider: FileImage(
                                                  File(c
                                                      .pickedImageSelfie!.path),
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
                                controller.selectImageSelfie();
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

              /// Upload surat
              Text(
                'Surat Pemberkatan Gereja, Vihara atau\nPure Dilegalisir',
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
                      GetBuilder<AktaNikahController>(
                        builder: (c) => c.pickedImageSuratNikah != null
                            ? Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      c.pickedImageSuratNikah!.name,
                                      style: blackTextStyle.copyWith(),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => c.resetImageSuratNikah(),
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
                            child: GetBuilder<AktaNikahController>(
                              builder: (c) {
                                return c.pickedImageSuratNikah != null
                                    ? ElevatedButton(
                                        onPressed: () {
                                          Get.dialog(
                                            Container(
                                              child: PhotoView(
                                                imageProvider: FileImage(
                                                  File(c.pickedImageSuratNikah!
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
                          Container(
                            width: 120.w,
                            height: 40.h,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.selectImageSuratNikah();
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

              /// Upload suket belum nikah
              Text(
                'Surat Ket Belum Menikah',
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
                      GetBuilder<AktaNikahController>(
                        builder: (c) => c.pickedImageSuketBNikah != null
                            ? Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      c.pickedImageSuketBNikah!.name,
                                      style: blackTextStyle.copyWith(),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => c.resetImageSuketBnikah(),
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
                            child: GetBuilder<AktaNikahController>(
                              builder: (c) {
                                return c.pickedImageSuketBNikah != null
                                    ? ElevatedButton(
                                        onPressed: () {
                                          Get.dialog(
                                            Container(
                                              child: PhotoView(
                                                imageProvider: FileImage(
                                                  File(c.pickedImageSuketBNikah!
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
                          Container(
                            width: 120.w,
                            height: 40.h,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.selectImageSuketBNikah();
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

              /// KTP SUAMI ISTRI
              Text(
                'Unggah KTP Suami & Istri',
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
                      GetBuilder<AktaNikahController>(
                        builder: (c) => c.pickedImageKTPsuamiIstri != null
                            ? Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      c.pickedImageKTPsuamiIstri!.name,
                                      style: blackTextStyle.copyWith(),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        c.resetImagektpSuamiIstri(),
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
                            child: GetBuilder<AktaNikahController>(
                              builder: (c) {
                                return c.pickedImageKTPsuamiIstri != null
                                    ? ElevatedButton(
                                        onPressed: () {
                                          Get.dialog(
                                            Container(
                                              child: PhotoView(
                                                imageProvider: FileImage(
                                                  File(c
                                                      .pickedImageKTPsuamiIstri!
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
                          Container(
                            width: 120.w,
                            height: 40.h,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.selectImagektpSuamiIstri();
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

              /// PAS FOTO SUAMI ISTRI
              Text(
                'Unggah Pas Foto Suami & Istri',
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
                      GetBuilder<AktaNikahController>(
                        builder: (c) => c.pickedImagepasFotoSuamiIstri != null
                            ? Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      c.pickedImagepasFotoSuamiIstri!.name,
                                      style: blackTextStyle.copyWith(),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        c.resetImagektppasFotoSuamiIstri(),
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
                            child: GetBuilder<AktaNikahController>(
                              builder: (c) {
                                return c.pickedImagepasFotoSuamiIstri != null
                                    ? ElevatedButton(
                                        onPressed: () {
                                          Get.dialog(
                                            Container(
                                              child: PhotoView(
                                                imageProvider: FileImage(
                                                  File(c
                                                      .pickedImagepasFotoSuamiIstri!
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
                          Container(
                            width: 120.w,
                            height: 40.h,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.selectImagepasFotoSuamiIstri();
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

              /// AKTA KELAHIRAN SUAMI
              Text(
                'Unggah Akta Kelahiran Suami',
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
                      GetBuilder<AktaNikahController>(
                        builder: (c) => c.pickedImageAktaKelahiranSuami != null
                            ? Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      c.pickedImageAktaKelahiranSuami!.name,
                                      style: blackTextStyle.copyWith(),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        c.resetImageAktaKelahiranSuami(),
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
                            child: GetBuilder<AktaNikahController>(
                              builder: (c) {
                                return c.pickedImageAktaKelahiranSuami != null
                                    ? ElevatedButton(
                                        onPressed: () {
                                          Get.dialog(
                                            Container(
                                              child: PhotoView(
                                                imageProvider: FileImage(
                                                  File(c
                                                      .pickedImageAktaKelahiranSuami!
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
                          Container(
                            width: 120.w,
                            height: 40.h,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.selectImageAktaKelahiranSuami();
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

              /// AKTA KELAHIRAN ISTRI
              Text(
                'Unggah Akta Kelahiran Istri',
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
                      GetBuilder<AktaNikahController>(
                        builder: (c) => c.pickedImageAktaKelahiranIstri != null
                            ? Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      c.pickedImageAktaKelahiranIstri!.name,
                                      style: blackTextStyle.copyWith(),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        c.resetImageAktaKelahiranIstri(),
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
                            child: GetBuilder<AktaNikahController>(
                              builder: (c) {
                                return c.pickedImageAktaKelahiranIstri != null
                                    ? ElevatedButton(
                                        onPressed: () {
                                          Get.dialog(
                                            Container(
                                              child: PhotoView(
                                                imageProvider: FileImage(
                                                  File(c
                                                      .pickedImageAktaKelahiranIstri!
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
                          Container(
                            width: 120.w,
                            height: 40.h,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.selectImageAktaKelahiranIstri();
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

              /// KTP SAKSI 1
              Text(
                'Unggah KTP Saksi 1',
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
                      GetBuilder<AktaNikahController>(
                        builder: (c) => c.pickedImageKTPsaksi1 != null
                            ? Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      c.pickedImageKTPsaksi1!.name,
                                      style: blackTextStyle.copyWith(),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => c.resetImageKTPsaksi1(),
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
                            child: GetBuilder<AktaNikahController>(
                              builder: (c) {
                                return c.pickedImageKTPsaksi1 != null
                                    ? ElevatedButton(
                                        onPressed: () {
                                          Get.dialog(
                                            Container(
                                              child: PhotoView(
                                                imageProvider: FileImage(
                                                  File(c.pickedImageKTPsaksi1!
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
                          Container(
                            width: 120.w,
                            height: 40.h,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.selectImageKTPSaksi1();
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

              /// KTP SAKSI 2
              Text(
                'Unggah KTP Saksi 2',
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
                      GetBuilder<AktaNikahController>(
                        builder: (c) => c.pickedImageKTPsaksi2 != null
                            ? Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      c.pickedImageKTPsaksi2!.name,
                                      style: blackTextStyle.copyWith(),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => c.resetImageKTPsaksi2(),
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
                            child: GetBuilder<AktaNikahController>(
                              builder: (c) {
                                return c.pickedImageKTPsaksi2 != null
                                    ? ElevatedButton(
                                        onPressed: () {
                                          Get.dialog(
                                            Container(
                                              child: PhotoView(
                                                imageProvider: FileImage(
                                                  File(c.pickedImageKTPsaksi2!
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
                          Container(
                            width: 120.w,
                            height: 40.h,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.selectImageKTPSaksi2();
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
        isActive: controller.currentStep.value >= 6,
      ),
    ];
  }
}
