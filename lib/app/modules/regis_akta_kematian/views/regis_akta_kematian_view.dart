import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pemohon_dukcapil_app/app/utils/custom_input_keterangan.dart';
import 'package:photo_view/photo_view.dart';
import '../../../shared/theme.dart';
import '../../../utils/custom_date_input.dart';
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
          'Jenazah',
          style: blackTextStyle.copyWith(fontSize: 12, fontWeight: semiBold),
        ),
        content: Form(
          key: controller.formKeys[0],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// NIK JENAZAH
              CustomTitleWidget(title: 'NIK'),
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
              CustomTitleWidget(title: 'Nama Lengkap'),
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
                textEditingController: controller.namaLengkapJenazahC,
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
                  controller.jenisKelaminJenazahC =
                      TextEditingController(text: value["jenisKelamin"]);
                },
              ),
              SizedBox(height: 20.h),

              /// TANGGAL LAHIR
              CustomTitleWidget(title: 'Tanggal lahir'),
              SizedBox(height: 12.h),
              TextFormField(
                controller: controller.tglLahirJenazahC,
                readOnly: true,
                onTap: () {
                  controller.tglLahirJenazah();
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
                textEditingController: controller.tempatLahirC,
                textCapitalization: TextCapitalization.words,
              ),
              SizedBox(height: 20.h),

              /// Agama
              CustomTitleWidget(title: 'Agama'),
              SizedBox(height: 12.h),
              DropdownSearch<Map<String, dynamic>>(
                dialogMaxWidth: 8,
                mode: Mode.MENU,
                items: controller.agama,
                dropdownButtonSplashRadius: 10,
                dropdownBuilder: (context, selectedItem) => Text(
                  selectedItem?["jenisAgama"].toString() ?? "PILIH",
                  style: blackTextStyle,
                ),
                popupItemBuilder: (context, item, isSelected) => ListTile(
                  title: Text(
                    item["jenisAgama"].toString(),
                    style: blackTextStyle,
                  ),
                ),
                showClearButton: true,
                onChanged: (value) {
                  print(value!["jenisAgama"]);
                  controller.agamaJenazah =
                      TextEditingController(text: value["jenisAgama"]);
                },
              ),
              SizedBox(height: 20.h),

              ///PEKERJAAN
              CustomTitleWidget(title: 'Pekerjaan)'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                textEditingController: controller.pekerjaanJenazahC,
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

              /// Alamat
              CustomTitleWidget(title: 'Alamat)'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                textEditingController: controller.alamatJenazahC,
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

              ///DESA
              /// Desa
              CustomTitleWidget(title: 'Desa/Kelurahan'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                textEditingController: controller.desaJenazahC,
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

              ///Kecamatan
              CustomTitleWidget(title: 'Kecamatan'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                textEditingController: controller.kecamatanJenazahC,
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

              ///Kabupaten/Kota
              CustomTitleWidget(title: 'Kabupaten/Kota'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                textEditingController: controller.kabupatenJenazahC,
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

              ///Provinsi
              CustomTitleWidget(title: 'Provinsi'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                textEditingController: controller.provinsiJenazahC,
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

              ///Tempat Kematian
              CustomTitleWidget(title: 'Tempat Kematian'),
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

              /// Yang Menerangkan
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

              /// Sebab Kematian
              CustomTitleWidget(title: 'Sebab Kematian'),
              SizedBox(height: 12.h),
              DropdownSearch<Map<String, dynamic>>(
                dialogMaxWidth: 8,
                mode: Mode.MENU,
                items: controller.sebabKematian,
                dropdownButtonSplashRadius: 10,
                dropdownBuilder: (context, selectedItem) => Text(
                  selectedItem?["sKematian"].toString() ?? "PILIH",
                  style: blackTextStyle,
                ),
                popupItemBuilder: (context, item, isSelected) => ListTile(
                  title: Text(
                    item["sKematian"].toString(),
                    style: blackTextStyle,
                  ),
                ),
                showClearButton: true,
                onChanged: (value) {
                  print(value!["sKematian"]);
                  controller.menerangkanC =
                      TextEditingController(text: value["sKematian"]);
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
          'Ayah/Kepala Keluarga',
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
                readOnly: false,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textEditingController: controller.nikAyahC,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Input tidak boleh kosong";
                  } else if (!GetUtils.isLengthEqualTo(value, 16)) {
                    return 'NIK harus 16 karakter';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.none,
              ),
              SizedBox(height: 12.h),
              SizedBox(height: 20.h),

              /// Nomor KK
              CustomTitleWidget(title: 'Nomor KK'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textEditingController: controller.noKepalaKeluargaC,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Input tidak boleh kosong";
                  } else if (!GetUtils.isLengthEqualTo(value, 16)) {
                    return 'Nomor KK harus 16 karakter';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.none,
              ),

              SizedBox(height: 20.h),

              ///NAMA LENGKAP
              CustomTitleWidget(title: 'Nama Lengkap'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textEditingController: controller.namaLengkapAyahC,
                keyboardType: TextInputType.name,
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

              ///TANGGAL LAHIR
              CustomTitleWidget(title: 'Tanggal lahir'),
              SizedBox(height: 12.h),
              CustomDateInput(
                onTap: () => controller.tglLahirAyah(),
                controller: controller.tanggalLahirAyahC,
              ),
              SizedBox(height: 20.h),

              ///PEKERJAAN
              CustomTitleWidget(title: 'Pekerjaan'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textEditingController: controller.pekerjaanAyahC,
                keyboardType: TextInputType.name,
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

              ///DESA
              CustomTitleWidget(title: 'Alamat'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textEditingController: controller.alamatAyah,
                keyboardType: TextInputType.name,
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

              ///DESA
              CustomTitleWidget(title: 'Desa/Kelurahan'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textEditingController: controller.desaAyah,
                keyboardType: TextInputType.name,
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

              ///Kecamatan
              CustomTitleWidget(title: 'Kecamatan'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textEditingController: controller.kecamatanAyahC,
                keyboardType: TextInputType.name,
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

              ///Kabupaten/kota
              CustomTitleWidget(title: 'Kabupaten/Kota'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textEditingController: controller.kabupatenAyahC,
                keyboardType: TextInputType.name,
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

              ///Provinsi
              CustomTitleWidget(title: 'Provinsi'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textEditingController: controller.provinsiAyahC,
                keyboardType: TextInputType.name,
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
        ),
        isActive: controller.currentStep.value >= 1,
        state:
            controller.currentStep > 1 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: Text(
          'Ibu',
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
                readOnly: false,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textEditingController: controller.nikIbuC,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Input tidak boleh kosong";
                  } else if (!GetUtils.isLengthEqualTo(value, 16)) {
                    return 'NIK harus 16 karakter';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.none,
              ),

              SizedBox(height: 20.h),

              ///NAMA LENGKAP
              CustomTitleWidget(title: 'Nama Lengkap'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textEditingController: controller.namaLengkapIbuC,
                keyboardType: TextInputType.name,
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

              ///TANGGAL LAHIR
              CustomTitleWidget(title: 'Tanggal lahir'),
              SizedBox(height: 12.h),
              CustomDateInput(
                onTap: () => controller.tglLahirIbu(),
                controller: controller.tanggalLahirIbuC,
              ),
              SizedBox(height: 20.h),

              ///PEKERJAAN
              CustomTitleWidget(title: 'Pekerjaan'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textEditingController: controller.pekerjaanIbuC,
                keyboardType: TextInputType.name,
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

              ///Alamat
              CustomTitleWidget(title: 'Alamat'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textEditingController: controller.alamatIbu,
                keyboardType: TextInputType.name,
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

              ///DESA
              CustomTitleWidget(title: 'Desa/Kelurahan'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textEditingController: controller.desaIbu,
                keyboardType: TextInputType.name,
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

              ///Kecamatan
              CustomTitleWidget(title: 'Kecamatan'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textEditingController: controller.kecamatanIbuC,
                keyboardType: TextInputType.name,
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

              ///Kabupaten/kota
              CustomTitleWidget(title: 'Kabupaten/Kota'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textEditingController: controller.kabupatenIbuC,
                keyboardType: TextInputType.name,
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

              ///Provinsi
              CustomTitleWidget(title: 'Provinsi'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textEditingController: controller.provinsiIbuC,
                keyboardType: TextInputType.name,
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
        ),
        isActive: controller.currentStep.value >= 2,
        state:
            controller.currentStep > 2 ? StepState.complete : StepState.indexed,
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
                controller.namaLengkapPemohonC.text = snapshot.data!["nama"];
                controller.nikPemohonC.text = snapshot.data!["nik"];
                controller.noTelepon.text = snapshot.data!["nomor_telp"];
                return Form(
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
                        textEditingController: controller.nikPemohonC,
                        textCapitalization: TextCapitalization.none,
                      ),

                      SizedBox(height: 20.h),

                      ///NAMA LENGKAP
                      CustomTitleWidget(title: 'Nama Lengkap'),
                      SizedBox(height: 12.h),
                      CustomFormField(
                        readOnly: true,
                        textEditingController: controller.namaLengkapPemohonC,
                        keyboardType: TextInputType.name,
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

                      ///TANGGAL LAHIR
                      CustomTitleWidget(title: 'Tanggal lahir'),
                      SizedBox(height: 12.h),
                      CustomDateInput(
                        onTap: () => controller.tglLahirPemohon(),
                        controller: controller.tanggalLahirPemohonC,
                      ),
                      SizedBox(height: 20.h),

                      ///PEKERJAAN
                      CustomTitleWidget(title: 'Pekerjaan'),
                      SizedBox(height: 12.h),
                      CustomFormField(
                        readOnly: false,
                        textEditingController: controller.pekerjaanPemohonC,
                        keyboardType: TextInputType.name,
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

                      ///Alamat
                      CustomTitleWidget(title: 'Alamat'),
                      SizedBox(height: 12.h),
                      CustomFormField(
                        readOnly: false,
                        textEditingController: controller.alamatPemohon,
                        keyboardType: TextInputType.name,
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

                      ///DESA
                      CustomTitleWidget(title: 'Desa/Kelurahan'),
                      SizedBox(height: 12.h),
                      CustomFormField(
                        readOnly: false,
                        textEditingController: controller.desaPemohon,
                        keyboardType: TextInputType.name,
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

                      ///Kecamatan
                      CustomTitleWidget(title: 'Kecamatan'),
                      SizedBox(height: 12.h),
                      CustomFormField(
                        readOnly: false,
                        textEditingController: controller.kecamatanPemohonC,
                        keyboardType: TextInputType.name,
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

                      ///Kabupaten/kota
                      CustomTitleWidget(title: 'Kabupaten/Kota'),
                      SizedBox(height: 12.h),
                      CustomFormField(
                        readOnly: false,
                        textEditingController: controller.kabupatenPemohonC,
                        keyboardType: TextInputType.name,
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

                      ///Provinsi
                      CustomTitleWidget(title: 'Provinsi'),
                      SizedBox(height: 12.h),
                      CustomFormField(
                        readOnly: false,
                        textEditingController: controller.provinsiPemohonC,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Input tidak boleh kosong";
                          } else {
                            return null;
                          }
                        },
                        textCapitalization: TextCapitalization.words,
                      ),

                      /// No. Telepon
                      CustomTitleWidget(title: 'No. Telepon'),
                      SizedBox(height: 12.h),
                      CustomFormField(
                        textCapitalization: TextCapitalization.none,
                        readOnly: true,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        textEditingController: controller.noTelepon,
                      ),
                    ],
                  ),
                );
              }
            }),
        isActive: controller.currentStep.value >= 3,
        state:
            controller.currentStep > 3 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: Text(
          'Saksi 1',
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
                readOnly: false,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textEditingController: controller.nikSaksi1C,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Input tidak boleh kosong";
                  } else if (!GetUtils.isLengthEqualTo(value, 16)) {
                    return 'NIK harus 16 karakter';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.none,
              ),

              SizedBox(height: 20.h),

              ///NAMA LENGKAP
              CustomTitleWidget(title: 'Nama Lengkap'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textEditingController: controller.namaLengkapSaksi1C,
                keyboardType: TextInputType.name,
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

              ///TANGGAL LAHIR
              CustomTitleWidget(title: 'Tanggal lahir'),
              SizedBox(height: 12.h),
              CustomDateInput(
                onTap: () => controller.tglLahirSaksi1(),
                controller: controller.tanggalLahirSaksi1C,
              ),
              SizedBox(height: 20.h),

              ///PEKERJAAN
              CustomTitleWidget(title: 'Pekerjaan'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textEditingController: controller.pekerjaanSaksi1C,
                keyboardType: TextInputType.name,
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

              ///Alamat
              CustomTitleWidget(title: 'Alamat'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textEditingController: controller.alamatSaksi1C,
                keyboardType: TextInputType.name,
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

              ///DESA
              CustomTitleWidget(title: 'Desa/Kelurahan'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textEditingController: controller.desaSaksi1,
                keyboardType: TextInputType.name,
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

              ///Kecamatan
              CustomTitleWidget(title: 'Kecamatan'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textEditingController: controller.kecamatanSaksi1C,
                keyboardType: TextInputType.name,
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

              ///Kabupaten/kota
              CustomTitleWidget(title: 'Kabupaten/Kota'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textEditingController: controller.kabupatenSaksi1C,
                keyboardType: TextInputType.name,
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

              ///Provinsi
              CustomTitleWidget(title: 'Provinsi'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textEditingController: controller.provinsiSaksi1C,
                keyboardType: TextInputType.name,
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
        ),
        isActive: controller.currentStep.value >= 4,
        state:
            controller.currentStep > 4 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: Text(
          'Persyaratan',
          style: blackTextStyle.copyWith(fontSize: 12, fontWeight: semiBold),
        ),
        content: Form(
          key: controller.formKeys[6],
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

                /// KK Pemohon
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
        isActive: controller.currentStep.value >= 6,
      ),
    ];
  }
}
