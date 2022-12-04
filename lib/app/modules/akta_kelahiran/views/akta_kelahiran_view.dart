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
import '../../../utils/custom_tittle_form.dart';
import '../../../utils/digital_clock_widget.dart';
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
                if (!controller
                    .formKeys[controller.currentStep.value].currentState!
                    .validate()) {
                  return;
                }
                if (controller.currentStep.value == formStep().length - 1) {
                  EasyLoading.show(status: 'memuat...');
                  controller.addreAktaKelahiran();
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
              /// NAMA LENGKAP
              CustomTitleWidget(title: 'Nama Lengkap'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textEditingController: controller.nameAnakC,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
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
                  controller.tempatDilahirkanC =
                      TextEditingController(text: value["tmptDilahirkan"]);
                },
              ),
              SizedBox(height: 20.h),

              /// Tempat Kelahiran
              CustomTitleWidget(title: 'Tempat Kelahiran'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textEditingController: controller.tempatKelahiranC,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
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

              /// KELAHIRAN KE
              CustomTitleWidget(title: 'Kelahiran Ke-'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textEditingController: controller.kelahiranKeC,
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

              ///PENOLONG KELAHIRAN
              CustomTitleWidget(title: 'Penolong Kelahiran'),
              SizedBox(height: 12.h),
              DropdownSearch<Map<String, dynamic>>(
                dialogMaxWidth: 8,
                mode: Mode.MENU,
                items: controller.penolongKelahiran,
                dropdownButtonSplashRadius: 10,
                dropdownBuilder: (context, selectedItem) => Text(
                  selectedItem?["pKelahiran"].toString() ?? "PILIH",
                  style: blackTextStyle,
                ),
                popupItemBuilder: (context, item, isSelected) => ListTile(
                  title: Text(
                    item["pKelahiran"].toString(),
                    style: blackTextStyle,
                  ),
                ),
                showClearButton: true,
                onChanged: (value) {
                  print(value!["pKelahiran"]);
                  controller.jenisKelahiranC =
                      TextEditingController(text: value["pKelahiran"]);
                },
              ),
              SizedBox(height: 20.h),

              ///TANGGAL LAHIR
              CustomTitleWidget(title: 'Tanggal lahir'),
              SizedBox(height: 12.h),
              CustomDateInput(
                onTap: () => controller.tglLahirAnak(),
                controller: controller.tglLahirAnakC,
              ),
              SizedBox(height: 20.h),

              /// PUKUL
              CustomTitleWidget(title: 'Pukul'),
              SizedBox(height: 12.h),
              DigitalClockWidget(
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.none,
                textEditingController: controller.pukulC,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Input tidak boleh kosong";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 20.h),

              ///JENIS KELAHIRAN
              CustomTitleWidget(title: 'Jenis Kelahiran'),
              SizedBox(height: 12.h),
              DropdownSearch<Map<String, dynamic>>(
                dialogMaxWidth: 8,
                mode: Mode.MENU,
                items: controller.jenisKelahiran,
                dropdownButtonSplashRadius: 10,
                dropdownBuilder: (context, selectedItem) => Text(
                  selectedItem?["jnsKelahiran"].toString() ?? "PILIH",
                  style: blackTextStyle,
                ),
                popupItemBuilder: (context, item, isSelected) => ListTile(
                  title: Text(
                    item["jnsKelahiran"].toString(),
                    style: blackTextStyle,
                  ),
                ),
                showClearButton: true,
                onChanged: (value) {
                  print(value!["jnsKelahiran"]);
                  controller.jenisKelahiranC =
                      TextEditingController(text: value["jnsKelahiran"]);
                },
              ),
              SizedBox(height: 20.h),

              /// BERAT BAYI
              CustomTitleWidget(title: 'Berat Bayi (Kg)'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textEditingController: controller.beratBayiC,
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

              /// Panjang Bayi
              CustomTitleWidget(title: 'Panjang Bayi(Cm)'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textEditingController: controller.panjangBayiC,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Input tidak boleh kosong";
                  } else {
                    return null;
                  }
                },
                textCapitalization: TextCapitalization.none,
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
              SizedBox(height: 12.h),

              ///NAMA LENGKAP
              CustomTitleWidget(title: 'Nama Lengkap'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textEditingController: controller.namaLengkapIbuC,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
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
                textEditingController: controller.pekerjaanIbu,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
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
                textEditingController: controller.desaIbuC,
                textInputAction: TextInputAction.next,
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
                textInputAction: TextInputAction.next,
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
                textInputAction: TextInputAction.next,
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
                textInputAction: TextInputAction.next,
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
                  controller.kewarganegaraanIbuC =
                      TextEditingController(text: value["jenisK"]);
                },
              ),
              SizedBox(height: 20.h),

              ///Kebangsaann
              CustomTitleWidget(title: 'Kebangsaan'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textEditingController: controller.kebangsaanC,
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

              ///TANGGAL PENCATATAN PERNIKAHAN
              CustomTitleWidget(title: 'Tanggal Pencatatan Pernikahan'),
              SizedBox(height: 12.h),
              CustomDateInput(
                onTap: () => controller.tglPencatatanPerkawinan(),
                controller: controller.tglPencatatanPerkawinanC,
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
                textEditingController: controller.noKKC,
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
                textEditingController: controller.pekerjaanAyah,
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
                  controller.kewarganegaraanAyah =
                      TextEditingController(text: value["jenisK"]);
                },
              ),
              SizedBox(height: 20.h),

              ///Kebangsaann
              CustomTitleWidget(title: 'Kebangsaan'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textEditingController: controller.kebangsaanAyahC,
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
          child: FutureBuilder<Map<String, dynamic>?>(
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
                  controller.namaLengkapPemohonC.text = snapshot.data!["nama"];
                  controller.nikPemohonC.text = snapshot.data!["nik"];
                  controller.emailPemohonC.text = snapshot.data!["email"];
                  controller.noTelpPemohonC.text = snapshot.data!["nomor_telp"];
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// NIK
                    CustomTitleWidget(title: 'NIK'),
                    SizedBox(height: 12.h),
                    CustomFormField(
                      readOnly: false,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      textEditingController: controller.nikPemohonC,
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

                    /// EMAIL
                    CustomTitleWidget(title: 'Email'),
                    SizedBox(height: 12.h),
                    CustomFormField(
                      readOnly: false,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      textEditingController: controller.emailPemohonC,
                      validator: (value) {
                        if (!GetUtils.isEmail(value!)) {
                          return 'Email tidak valid';
                        } else {
                          return null;
                        }
                      },
                      textCapitalization: TextCapitalization.none,
                    ),

                    SizedBox(height: 20.h),

                    /// Nomor Telepon
                    CustomTitleWidget(title: 'Nomor Telepon'),
                    SizedBox(height: 12.h),
                    CustomFormField(
                      readOnly: false,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      textEditingController: controller.noTelpPemohonC,
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]+$')
                                .hasMatch(value)) {
                          return "Masukan nomor telepon yang benar";
                        } else if (!GetUtils.isLengthGreaterOrEqual(
                            value, 11)) {
                          return 'Minimal 12 karakter';
                        } else {
                          return null;
                        }
                      },
                      textCapitalization: TextCapitalization.none,
                    ),
                    SizedBox(height: 20.h),

                    ///TANGGAL LAHIR
                    CustomTitleWidget(title: 'Tanggal lahir'),
                    SizedBox(height: 12.h),
                    CustomDateInput(
                      onTap: () => controller.tglLahirPemohon(),
                      controller: controller.tglLahirPemohonC,
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

                    ///DESA
                    CustomTitleWidget(title: 'Desa/Kelurahan'),
                    SizedBox(height: 12.h),
                    CustomFormField(
                      readOnly: false,
                      textEditingController: controller.desaPemohonC,
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
                        controller.kewarganegaraanPemohonC =
                            TextEditingController(text: value["jenisK"]);
                      },
                    ),
                    SizedBox(height: 20.h),
                  ],
                );
              }),
        ),
        isActive: controller.currentStep.value >= 3,
        state:
            controller.currentStep > 3 ? StepState.complete : StepState.indexed,
      ),

      ///SAKSI 1
      Step(
        title: Text(
          'Saksi 1 (Satu)',
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
                controller: controller.tglLahirSaksi1C,
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

              ///DESA
              CustomTitleWidget(title: 'Desa/Kelurahan'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textEditingController: controller.desaSaksi1C,
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

      ///SAKSI 2
      Step(
        title: Text(
          'Saksi 2 (Dua)',
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
                readOnly: false,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textEditingController: controller.nikSaksi2C,
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
                textEditingController: controller.namaLengkapSaksi2C,
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
                onTap: () => controller.tglLahirSaksi2(),
                controller: controller.tglLahirSaksi2C,
              ),
              SizedBox(height: 20.h),

              ///PEKERJAAN
              CustomTitleWidget(title: 'Pekerjaan'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textEditingController: controller.pekerjaanSaksi2C,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
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
                textEditingController: controller.desaSaksi2C,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
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
                textInputAction: TextInputAction.next,
                readOnly: false,
                textEditingController: controller.kecamatanSaksi2C,
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
                textEditingController: controller.kabupatenSaksi2C,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
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
                textEditingController: controller.provinsiSaksi2C,
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
        content: Form(
          key: controller.formKeys[6],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///SUKET
              Text(
                'SUKET dari RS/PUSKESMAS',
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
                        builder: (c) => c.pickedImageSuket != null
                            ? Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      c.pickedImageSuket!.name,
                                      style: blackTextStyle.copyWith(),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => c.resetImageSuket(),
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
                                return c.pickedImageSuket != null
                                    ? ElevatedButton(
                                        onPressed: () {
                                          Get.dialog(
                                            Container(
                                              child: PhotoView(
                                                imageProvider: FileImage(
                                                  File(
                                                      c.pickedImageSuket!.path),
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
                                controller.selectImageSuket();
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
                      GetBuilder<AktaKelahiranController>(
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
                            child: GetBuilder<AktaKelahiranController>(
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
                      GetBuilder<AktaKelahiranController>(
                        builder: (c) => c.pickedImageAktaNikah != null
                            ? Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      c.pickedImageAktaNikah!.name,
                                      style: blackTextStyle.copyWith(),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => c.resetImageAktaNikah(),
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
                                return c.pickedImageAktaNikah != null
                                    ? ElevatedButton(
                                        onPressed: () {
                                          Get.dialog(
                                            Container(
                                              child: PhotoView(
                                                imageProvider: FileImage(
                                                  File(c.pickedImageAktaNikah!
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
                                controller.selectImageAktaNikah();
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
