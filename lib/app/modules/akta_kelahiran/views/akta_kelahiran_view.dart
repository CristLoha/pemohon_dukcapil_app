import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import '../../../shared/theme.dart';
import '../../../utils/custom_form_input.dart';
import '../../../utils/custom_input_keterangan.dart';
import '../../../utils/custom_tittle_form.dart';
import '../controllers/akta_kelahiran_controller.dart';

class AktaKelahiranView extends GetView<AktaKelahiranController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Akta Kelahiran'),
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
      /// BAYI/ANAK
      Step(
        title: Text(
          'Bayi/Anak',
          style: blackTextStyle.copyWith(fontWeight: semiBold),
        ),
        content: Form(
          key: controller.formKeys[0],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitleWidget(title: 'Nama Lengkap'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textEditingController: controller.nameC,
                keyboardType: TextInputType.number,
                textCapitalization: TextCapitalization.words,
              ),
              SizedBox(height: 20.h),

              /// Jenis Kelamin
              CustomTitleWidget(title: 'Jenis Kelamin'),
              SizedBox(height: 12.h),
              DropdownSearch<Map<String, dynamic>>(
                dialogMaxWidth: 8,
                mode: Mode.MENU,
                items: controller.dataJenisKelamin,
                dropdownButtonSplashRadius: 10,
                dropdownBuilder: (context, selectedItem) => Text(
                  selectedItem?["jenisKelamin"].toString() ?? "PILIH",
                  style: blackTextStyle,
                ),
                popupItemBuilder: (context, item, isSelected) => ListTile(
                  title: Text(
                    item["jenisKelamin"].toString(),
                    style: blackTextStyle,
                  ),
                ),
                showClearButton: true,
                onChanged: (value) {
                  print(value!["jenisKelamin"]);
                  controller.jenisKelaminC =
                      TextEditingController(text: value["jenisKelamin"]);
                },
              ),
              SizedBox(height: 20.h),

              /// TEMPAT DILAHIRKAN

              CustomTitleWidget(title: 'Tempat Dilahirkan'),
              SizedBox(height: 12.h),
              DropdownSearch<Map<String, dynamic>>(
                dialogMaxWidth: 8,
                mode: Mode.MENU,
                items: controller.tempatDilahirkan,
                dropdownButtonSplashRadius: 10,
                dropdownBuilder: (context, selectedItem) => Text(
                  selectedItem?["tmptDilahirkan"].toString() ?? "PILIH",
                  style: blackTextStyle,
                ),
                popupItemBuilder: (context, item, isSelected) => ListTile(
                  title: Text(
                    item["tmptDilahirkan"].toString(),
                    style: blackTextStyle,
                  ),
                ),
                showClearButton: true,
                onChanged: (value) {
                  print(value!["tmptDilahirkan"]);
                  controller.jenisKelaminC =
                      TextEditingController(text: value["tmptDilahirkan"]);
                },
              ),
              SizedBox(height: 20.h),

              ///TANGGAL LAHIR
              SizedBox(height: 20.h),
              CustomTitleWidget(title: 'Tanggal lahir'),
              SizedBox(height: 12.h),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: controller.dateC,
                readOnly: true,
                onTap: () {
                  controller.dateLocal();
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
              SizedBox(height: 12.h),

              /// DESA
              CustomTitleWidget(title: 'Desa'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.name,
                textEditingController: controller.desaC,
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

              ///Keterangan
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

      /// Ibu
      Step(
        title: Text(
          'Ibu',
          style: blackTextStyle.copyWith(fontWeight: semiBold),
        ),
        content: Form(
          key: controller.formKeys[1],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// NIK
              CustomTitleWidget(title: 'NIK'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: true,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textEditingController: controller.nikC,
                textCapitalization: TextCapitalization.none,
              ),
              SizedBox(height: 20.h),
              CustomTitleWidget(title: 'Nama Lengkap'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: true,
                textEditingController: controller.nameC,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
              ),

              SizedBox(height: 20.h),
              CustomTitleWidget(title: 'Tanggal lahir'),
              SizedBox(height: 12.h),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: controller.dateC,
                readOnly: true,
                onTap: () {
                  controller.dateLocal();
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
              SizedBox(height: 12.h),

              /// DESA
              CustomTitleWidget(title: 'Desa'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.name,
                textEditingController: controller.desaC,
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

              ///Keterangan
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
        isActive: controller.currentStep.value >= 1,
        state:
            controller.currentStep > 1 ? StepState.complete : StepState.indexed,
      ),

      /// AYAH/KEPALA KELUARGA
      Step(
        title: Text(
          'Kepala Keluarga/Ayah',
          style: blackTextStyle.copyWith(fontWeight: semiBold),
        ),
        content: Form(
          key: controller.formKeys[2],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// NIK
              CustomTitleWidget(title: 'NIK'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: true,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textEditingController: controller.nikC,
                textCapitalization: TextCapitalization.none,
              ),
              SizedBox(height: 20.h),
              CustomTitleWidget(title: 'Nama Lengkap'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: true,
                textEditingController: controller.nameC,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
              ),

              SizedBox(height: 20.h),
              CustomTitleWidget(title: 'Tanggal lahir'),
              SizedBox(height: 12.h),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: controller.dateC,
                readOnly: true,
                onTap: () {
                  controller.dateLocal();
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
              SizedBox(height: 12.h),

              /// DESA
              CustomTitleWidget(title: 'Desa'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.name,
                textEditingController: controller.desaC,
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

              ///Keterangan
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
        isActive: controller.currentStep.value >= 2,
        state:
            controller.currentStep > 2 ? StepState.complete : StepState.indexed,
      ),

      ///PEMOHON
      Step(
        title: Text(
          'Pemohon',
          style: blackTextStyle.copyWith(fontWeight: semiBold),
        ),
        content: Form(
          key: controller.formKeys[3],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// NIK
              CustomTitleWidget(title: 'NIK'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: true,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textEditingController: controller.nikC,
                textCapitalization: TextCapitalization.none,
              ),
              SizedBox(height: 20.h),
              CustomTitleWidget(title: 'Nama Lengkap'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: true,
                textEditingController: controller.nameC,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
              ),

              SizedBox(height: 20.h),
              CustomTitleWidget(title: 'Tanggal lahir'),
              SizedBox(height: 12.h),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: controller.dateC,
                readOnly: true,
                onTap: () {
                  controller.dateLocal();
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
              SizedBox(height: 12.h),

              /// DESA
              CustomTitleWidget(title: 'Desa'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.name,
                textEditingController: controller.desaC,
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

              ///Keterangan
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
        isActive: controller.currentStep.value >= 3,
        state:
            controller.currentStep > 3 ? StepState.complete : StepState.indexed,
      ),

      /// SAKSI 1
      Step(
        title: Text(
          'Kepala Keluarga/Ayah',
          style: blackTextStyle.copyWith(fontWeight: semiBold),
        ),
        content: Form(
          key: controller.formKeys[4],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// NIK
              CustomTitleWidget(title: 'NIK'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: true,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textEditingController: controller.nikC,
                textCapitalization: TextCapitalization.none,
              ),
              SizedBox(height: 20.h),
              CustomTitleWidget(title: 'Nama Lengkap'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: true,
                textEditingController: controller.nameC,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
              ),

              SizedBox(height: 20.h),
              CustomTitleWidget(title: 'Tanggal lahir'),
              SizedBox(height: 12.h),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: controller.dateC,
                readOnly: true,
                onTap: () {
                  controller.dateLocal();
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
              SizedBox(height: 12.h),

              /// DESA
              CustomTitleWidget(title: 'Desa'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.name,
                textEditingController: controller.desaC,
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

              ///Keterangan
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
        isActive: controller.currentStep.value >= 4,
        state:
            controller.currentStep > 4 ? StepState.complete : StepState.indexed,
      ),

      ///SAKSI 2
      Step(
        title: Text(
          'Kepala Keluarga/Ayah',
          style: blackTextStyle.copyWith(fontWeight: semiBold),
        ),
        content: Form(
          key: controller.formKeys[5],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// NIK
              CustomTitleWidget(title: 'NIK'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: true,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textEditingController: controller.nikC,
                textCapitalization: TextCapitalization.none,
              ),
              SizedBox(height: 20.h),
              CustomTitleWidget(title: 'Nama Lengkap'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: true,
                textEditingController: controller.nameC,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
              ),

              SizedBox(height: 20.h),
              CustomTitleWidget(title: 'Tanggal lahir'),
              SizedBox(height: 12.h),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: controller.dateC,
                readOnly: true,
                onTap: () {
                  controller.dateLocal();
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
              SizedBox(height: 12.h),

              /// DESA
              CustomTitleWidget(title: 'Desa'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.name,
                textEditingController: controller.desaC,
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

              ///Keterangan
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
        isActive: controller.currentStep.value >= 5,
        state:
            controller.currentStep > 5 ? StepState.complete : StepState.indexed,
      ),

      ///UNGGAH PERSYARATAN
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
                    GetBuilder<AktaKelahiranController>(
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
                          child: GetBuilder<AktaKelahiranController>(
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
        isActive: controller.currentStep.value >= 6,
      ),
    ];
  }
}
