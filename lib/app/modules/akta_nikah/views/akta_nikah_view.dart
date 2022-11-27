import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import '../../../shared/theme.dart';
import '../../../utils/custom_form_input.dart';
import '../../../utils/custom_input_keterangan.dart';
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
        title: Text(
          'Formulir Perkawinan',
          style: blackTextStyle.copyWith(fontWeight: semiBold),
        ),
        content: Form(
          key: controller.formKeys[0],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Formulir Perkawinan',
                  style: blackTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              /// NIK SUAMI
              CustomTitleWidget(title: 'NIK Suami'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textEditingController: controller.nikSuamiC,
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]+$')
                          .hasMatch(value)) {
                    return "Masukan Nomor NIK yang benar";
                  } else if (!GetUtils.isLengthEqualTo(value, 16)) {
                    return 'NIK harus 16 karakter';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20.h),

              /// Nama Lengkap Suami
              CustomTitleWidget(title: 'Nama Lengkap Suami'),
              SizedBox(height: 12.h),
              CustomFormField(
                  textCapitalization: TextCapitalization.words,
                  readOnly: false,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  textEditingController: controller.namaLengkapSuamiC),
              SizedBox(height: 20.h),

              /// Tempat Lahir Suami
              CustomTitleWidget(title: 'Tempat Lahir Suami'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                textEditingController: controller.tempatLahirSuamiC,
                onTap: () {},
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                    return "Masukan nama tempat lahir yang benar";
                  } else {
                    return null;
                  }
                },
                textCapitalization: TextCapitalization.words,
              ),

              SizedBox(height: 20.h),
              CustomTitleWidget(title: 'Tanggal lahir Suami'),
              SizedBox(height: 12.h),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: controller.dateC,
                readOnly: true,
                onTap: () {
                  controller.tglLahirSuami();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Silahkan masukkan tanggal lahir';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintStyle: greyTextStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),

              /// Kecamatan
              CustomTitleWidget(title: 'Kecamatan'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                textEditingController: controller.kecamatanC,
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

              /// Desa
              CustomTitleWidget(title: 'Desa'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                textEditingController: controller.desaC,
                onTap: () {},
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                    return "Masukan nama desa yang benar";
                  } else {
                    return null;
                  }
                },
                textCapitalization: TextCapitalization.words,
              ),

              SizedBox(height: 20.h),

              /// Keterangan
              CustomTitleWidget(title: 'Daftar Anggota'),
              SizedBox(height: 12.h),
              CustomFormKeteranganField(
                hintText:
                    'Cth: Nama\n\n1. Christ Henry Loha \n2. Steve Imanuel Loha \ndst..\nNIK:\n1. ',
                readOnly: false,
                textInputAction: TextInputAction.newline,
                textEditingController: controller.keteranganC,
              ),
              SizedBox(height: 20.h),

              /// Keterangan
              CustomTitleWidget(title: 'Keterangan'),
              SizedBox(height: 12.h),
              CustomFormKeteranganField(
                readOnly: false,
                textInputAction: TextInputAction.done,
                textEditingController: controller.keteranganC,
              ),
            ],
          ),
        ),
        isActive: controller.currentStep.value >= 0,
        state:
            controller.currentStep > 0 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: Text('Persyaratan',
            style: blackTextStyle.copyWith(fontWeight: semiBold)),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    GetBuilder<AktaNikahController>(
                      builder: (c) => c.pickedImage != null
                          ? Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    c.pickedImage!.name,
                                    style: blackTextStyle.copyWith(),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => c.resetImage(),
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
                              return c.pickedImage != null
                                  ? ElevatedButton(
                                      onPressed: () {
                                        Get.dialog(
                                          Container(
                                            child: PhotoView(
                                              imageProvider: FileImage(
                                                File(c.pickedImage!.path),
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
                              controller.selectImage();
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
        isActive: controller.currentStep.value >= 1,
      ),
    ];
  }
}
