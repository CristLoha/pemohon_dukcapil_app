import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pemohon_dukcapil_app/app/utils/custom_input_keterangan.dart';
import 'package:photo_view/photo_view.dart';
import '../../../shared/theme.dart';
import '../../../utils/custom_form_input.dart';
import '../../../utils/custom_tittle_form.dart';
import '../controllers/regis_akta_kematian_controller.dart';

class RegisAktaKematianView extends GetView<RegisAktaKematianController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Akta Kematian'),
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
                    controller.addPerubahanKTP();
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
          'Akta\nKematian',
          style: blackTextStyle.copyWith(fontSize: 12, fontWeight: semiBold),
        ),
        content: Form(
          key: controller.formKeys[0],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Formulir Akta Kematian',
                  style: blackTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              /// NIK JENAZAH
              CustomTitleWidget(title: 'NIK Jenazah'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textEditingController: controller.nikJenazahC,
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

              /// Nama Lengkap Jenazah
              CustomTitleWidget(title: 'Nama Lengkap Jenazah'),
              SizedBox(height: 12.h),
              CustomFormField(
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
                textEditingController: controller.nameJenazahC,
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

              /// TANGGAL LAHIR
              CustomTitleWidget(title: 'Tanggal lahir'),
              SizedBox(height: 12.h),
              TextFormField(
                controller: controller.dateC,
                readOnly: true,
                onTap: () {
                  controller.dateLocal();
                },
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return 'Masukan tanggal lahir';
                //   } else {
                //     return null;
                //   }
                // },
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

              /// Tempat lahir
              CustomTitleWidget(title: 'Tempat Lahir'),
              SizedBox(height: 12.h),
              CustomFormField(
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
                textEditingController: controller.nameTempatLahirC,
                textCapitalization: TextCapitalization.words,
              ),
              SizedBox(height: 20.h),

              /// Kewarganegaraan
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
                  controller.kewarganegaraanC =
                      TextEditingController(text: value["jenisK"]);
                },
              ),
              SizedBox(height: 20.h),

              /// Tempat kematian
              CustomTitleWidget(title: 'Tempat Kematian (Kabupaten / Kota)'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                textEditingController: controller.tempatKematianC,
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

              /// Anak Ke
              CustomTitleWidget(title: 'Anak Ke'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Input tidak boleh kosong";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                textEditingController: controller.anakKe,
                textCapitalization: TextCapitalization.none,
              ),
              SizedBox(height: 20.h),

              /// TANGGAL KEMATIAN
              CustomTitleWidget(title: 'Tanggal Kematian'),
              SizedBox(height: 12.h),
              TextFormField(
                controller: controller.tanggalKematianC,
                readOnly: true,
                onTap: () {
                  controller.dateKematian();
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

              /// Yang menerangkan
              CustomTitleWidget(title: 'Yang Menerangkan'),
              SizedBox(height: 12.h),
              DropdownSearch<Map<String, dynamic>>(
                dialogMaxWidth: 8,
                mode: Mode.MENU,
                items: controller.dataJenisYgMenerangkan,
                dropdownButtonSplashRadius: 10,
                dropdownBuilder: (context, selectedItem) => Text(
                  selectedItem?["menerangkan"].toString() ?? "PILIH",
                  style: blackTextStyle,
                ),
                popupItemBuilder: (context, item, isSelected) => ListTile(
                  title: Text(
                    item["menerangkan"].toString(),
                    style: blackTextStyle,
                  ),
                ),
                showClearButton: true,
                onChanged: (value) {
                  print(value!["menerangkan"]);
                  controller.menerangkanC =
                      TextEditingController(text: value["menerangkan"]);
                },
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
        title: Text('Pemohon',
            style: blackTextStyle.copyWith(fontSize: 12, fontWeight: semiBold)),
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
                controller.nameC.text = snapshot.data!["nama"];
                controller.nikC.text = snapshot.data!["nik"];
                return Form(
                  key: controller.formKeys[1],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Formulir Pendaftaran Antrian Perubahan e-KTP',
                          style: blackTextStyle.copyWith(
                            fontWeight: semiBold,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),

                      /// NIK AYAH
                      CustomTitleWidget(title: 'NIK Ayah'),
                      SizedBox(height: 12.h),
                      CustomFormField(
                        readOnly: false,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        textEditingController: controller.nikAyahC,
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

                      /// Nama Ayah
                      CustomTitleWidget(title: 'Nama Ayah'),
                      SizedBox(height: 12.h),
                      CustomFormField(
                        readOnly: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Input tidak boleh kosong";
                          } else {
                            return null;
                          }
                        },
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        textEditingController: controller.namaAyahC,
                        onTap: () {},
                        textCapitalization: TextCapitalization.words,
                      ),
                      SizedBox(height: 20.h),

                      /// NIK IBU
                      CustomTitleWidget(title: 'NIK Ibu'),
                      SizedBox(height: 12.h),
                      CustomFormField(
                        readOnly: false,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        textEditingController: controller.nikIbuC,
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

                      /// Nama Ibu
                      CustomTitleWidget(title: 'Nama Ibu'),
                      SizedBox(height: 12.h),
                      CustomFormField(
                        readOnly: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Input tidak boleh kosong";
                          } else {
                            return null;
                          }
                        },
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        textEditingController: controller.namaIbuC,
                        textCapitalization: TextCapitalization.words,
                      ),
                      SizedBox(height: 20.h),

                      /// NIK
                      CustomTitleWidget(title: 'NIK'),
                      SizedBox(height: 12.h),
                      CustomFormField(
                        readOnly: false,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        textEditingController: controller.nikC,
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
                        textEditingController: controller.nameC,
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

                      /// No. Telepon
                      CustomTitleWidget(title: 'No. Telepon'),
                      SizedBox(height: 12.h),
                      CustomFormField(
                        textCapitalization: TextCapitalization.none,
                        readOnly: false,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        textEditingController: controller.noTeleponC,
                        onTap: () {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Input tidak boleh kosong";
                          } else if (!GetUtils.isLengthGreaterOrEqual(
                              value, 11)) {
                            return 'Minimal 12 karakter';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                );
              }
            }),
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
          key: controller.formKeys[2],
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// KTP JenazaH
                Text(
                  'Unggah KTP Jenazah',
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
                        GetBuilder<RegisAktaKematianController>(
                          builder: (c) => c.pickedImageKTPJenazah != null
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        c.pickedImageKTPJenazah!.name,
                                        style: blackTextStyle.copyWith(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () => c.resetImageKTPJenazah(),
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
                            GestureDetector(
                              child: Container(
                                width: 120.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: GetBuilder<RegisAktaKematianController>(
                                  builder: (c) {
                                    return c.pickedImageKTPJenazah != null
                                        ? ElevatedButton(
                                            onPressed: () {
                                              Get.dialog(
                                                Container(
                                                  child: PhotoView(
                                                    imageProvider: FileImage(
                                                      File(c
                                                          .pickedImageKTPJenazah!
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
                                  controller.selectImageKTPJenazah();
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
                        GetBuilder<RegisAktaKematianController>(
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
                                child: GetBuilder<RegisAktaKematianController>(
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
                  'Unggah Akta Kelahiran/Surat Pernyataan tidak memiliki Akta Kelahiran',
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
                        GetBuilder<RegisAktaKematianController>(
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
                                child: GetBuilder<RegisAktaKematianController>(
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

                ///KTP PELAPOR
                Text(
                  'Unggah KTP Pemohon',
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
                        GetBuilder<RegisAktaKematianController>(
                          builder: (c) => c.pickedImageKtpPelapor != null
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        c.pickedImageKtpPelapor!.name,
                                        style: blackTextStyle.copyWith(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () => c.resetImageKtpPelapor(),
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
                                child: GetBuilder<RegisAktaKematianController>(
                                  builder: (c) {
                                    return c.pickedImageKtpPelapor != null
                                        ? ElevatedButton(
                                            onPressed: () {
                                              Get.dialog(
                                                Container(
                                                  child: PhotoView(
                                                    imageProvider: FileImage(
                                                      File(c
                                                          .pickedImageKtpPelapor!
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
                                  controller.selectKtpPelapor();
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

                /// KK pelapor
                Text(
                  'Unggah KK Pemohon',
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
                        GetBuilder<RegisAktaKematianController>(
                          builder: (c) => c.pickedImageKKPelapor != null
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        c.pickedImageKKPelapor!.name,
                                        style: blackTextStyle.copyWith(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () => c.resetImageKKPelapor(),
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
                                child: GetBuilder<RegisAktaKematianController>(
                                  builder: (c) {
                                    return c.pickedImageKKPelapor != null
                                        ? ElevatedButton(
                                            onPressed: () {
                                              Get.dialog(
                                                Container(
                                                  child: PhotoView(
                                                    imageProvider: FileImage(
                                                      File(c
                                                          .pickedImageKKPelapor!
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
                                  controller.selectKKPelapor();
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
