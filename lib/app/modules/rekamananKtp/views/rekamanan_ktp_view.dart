import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pemohon_dukcapil_app/app/shared/theme.dart';
import 'package:pemohon_dukcapil_app/app/utils/custom_form_input.dart';
import 'package:pemohon_dukcapil_app/app/utils/custom_input_keterangan.dart';
import 'package:photo_view/photo_view.dart';
import '../../../utils/custom_date_input.dart';
import '../../../utils/custom_tittle_form.dart';
import '../controllers/rekamanan_ktp_controller.dart';

class RekamananKtpView extends GetView<RekamananKtpController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Perekaman e-KTP'),
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
                controller.nameC.text = snapshot.data!["nama"];

                controller.noTelpC.text = snapshot.data!["nomor_telp"];
                controller.nikC.text = snapshot.data!["nik"];

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
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        textEditingController: controller.nikC,
                        textCapitalization: TextCapitalization.none,
                      ),
                      SizedBox(height: 20.h),
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

                      ///tanggal lahir
                      SizedBox(height: 20.h),
                      CustomTitleWidget(title: 'Tanggal lahir'),
                      SizedBox(height: 12.h),
                      CustomDateInput(
                          onTap: () => controller.dateLocal(),
                          controller: controller.dateC),

                      /// Provinsi
                      SizedBox(height: 20.h),
                      CustomTitleWidget(title: 'Provinsi'),
                      SizedBox(height: 12.h),
                      CustomFormField(
                        readOnly: false,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        textEditingController: controller.provinsiC,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Input tidak boleh kosong";
                          } else {
                            return null;
                          }
                        },
                        textCapitalization: TextCapitalization.words,
                      ),

                      /// Provinsi
                      SizedBox(height: 20.h),
                      CustomTitleWidget(title: 'Kabupaten'),
                      SizedBox(height: 12.h),
                      CustomFormField(
                        readOnly: false,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        textEditingController: controller.kabupatenC,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Input tidak boleh kosong";
                          } else {
                            return null;
                          }
                        },
                        textCapitalization: TextCapitalization.words,
                      ),

                      /// Kecamatan
                      SizedBox(height: 20.h),
                      CustomTitleWidget(title: 'Kecamatan'),
                      SizedBox(height: 12.h),
                      CustomFormField(
                        readOnly: false,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        textEditingController: controller.kecamatanC,
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

                      /// DESA
                      SizedBox(height: 20.h),
                      CustomTitleWidget(title: 'Desa'),
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
                );
              }
            }),
        isActive: controller.currentStep.value >= 0,
        state:
            controller.currentStep > 0 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: Text('Persyaratan',
            style: blackTextStyle.copyWith(fontWeight: semiBold)),
        content: Form(
          key: controller.formKeys[1],
          child: Column(
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
                      GetBuilder<RekamananKtpController>(
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
                            child: GetBuilder<RekamananKtpController>(
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
        ),
        isActive: controller.currentStep.value >= 1,
      ),
    ];
  }
}
