import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:photo_view/photo_view.dart';
import '../../../shared/theme.dart';
import '../../../utils/custom_form_input.dart';
import '../../../utils/custom_input_keterangan.dart';
import '../../../utils/custom_tittle_form.dart';
import '../controllers/kartu_keluarga_controller.dart';

class KartuKeluargaView extends GetView<KartuKeluargaController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Registrasi KK'),
        backgroundColor: kPrimaryColor,
      ),
      body: Obx(
        (() => Container(
              child: Stepper(
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
                    controller.addKIA();
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
          style: blackTextStyle.copyWith(fontSize: 12, fontWeight: semiBold),
        ),
        content: Form(
          key: controller.formKeys[0],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Permohonan Kartu Keluarga Baru',
                  style: blackTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              /// NIK
              CustomTitleWidget(title: 'NIK'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textEditingController: controller.nik,
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

              /// Nama Lengkap
              CustomTitleWidget(title: 'Nama Lengkap'),
              SizedBox(height: 12.h),
              CustomFormField(
                  textCapitalization: TextCapitalization.words,
                  readOnly: false,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  textEditingController: controller.namaLengkapC),
              SizedBox(height: 20.h),

              /// No. Kk Semula
              CustomTitleWidget(title: 'No. KK Semula'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textEditingController: controller.nik,
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]+$')
                          .hasMatch(value)) {
                    return "Masukan nomor kk yang benar";
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
                textEditingController: controller.desaC,
                onTap: () {},
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                    return "Masukan nama  kabupaten/kota yang benar";
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

              /// Kode Pos
              CustomTitleWidget(title: 'Kode Pos'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textEditingController: controller.nik,
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]+$')
                          .hasMatch(value)) {
                    return "Masukan kode pos yang benar";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),
              SizedBox(height: 20.h),

              /// Jumlah Anggota Keluarga
              CustomTitleWidget(title: 'Jml Anggota Keluarga'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textEditingController: controller.nik,
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]+$')
                          .hasMatch(value)) {
                    return "Masukan kode pos yang benar";
                  }
                  return null;
                },
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
                textEditingController: controller.daftarAnggotaC,
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
        title: Text('Daftar',
            style: blackTextStyle.copyWith(fontSize: 12, fontWeight: semiBold)),
        content: Form(
          key: controller.formKeys[1],
          child: HorizontalDataTable(
            leftHandSideColumnWidth: 220,
            rightHandSideColumnWidth: 100,
            leftSideChildren: [
              Text('1'),
              Text('1'),
              Text('1'),
            ],
            rightSideChildren: [
              Text('1'),
              Text('1'),
              Text('1'),
            ],
            headerWidgets: [Text('1'), Text('2'), Text('3')],
          ),
        ),

        ///
        isActive: controller.currentStep.value >= 1,
        state:
            controller.currentStep > 1 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: Text(
          'Persyaratan',
          style: blackTextStyle.copyWith(fontSize: 12, fontWeight: semiBold),
        ),
        content: Form(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// KK
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

                ///AKTA KELAHIRAN
                Text(
                  'Unggah Akta Kelahiran',
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
                          builder: (c) => c.pickedImageAktaKelahiran != null
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        c.pickedImageAktaKelahiran!.name,
                                        style: blackTextStyle.copyWith(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          c.resetImageAktaKelahiran(),
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
                                    return c.pickedImageAktaKelahiran != null
                                        ? ElevatedButton(
                                            onPressed: () {
                                              Get.dialog(
                                                Container(
                                                  child: PhotoView(
                                                    imageProvider: FileImage(
                                                      File(c
                                                          .pickedImageAktaKelahiran!
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
                                  controller.selectImageAktaKelahiran();
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
              ],
            ),
          ),
        ),
        isActive: controller.currentStep.value >= 2,
      ),
    ];
  }
}
