import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pemohon_dukcapil_app/app/shared/theme.dart';
import 'package:pemohon_dukcapil_app/app/utils/custom_form_input.dart';
import '../../../utils/custom_tittle_form.dart';
import '../controllers/rekamanan_ktp_controller.dart';

class RekamananKtpView extends GetView<RekamananKtpController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Daftar rekam e-KTP'),
        backgroundColor: kPrimaryColor,
      ),
      body: Obx(
        (() => Stepper(
              elevation: 1,
              type: StepperType.horizontal,
              steps: formStep(),
              onStepContinue: () {
                if (controller.currentStep.value == formStep().length - 1) {
                  print('send data to server');
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
                          width: 120,
                          margin:
                              EdgeInsets.only(top: 30, bottom: 40, left: 20),
                          child: (Container(
                            child: ElevatedButton(
                              onPressed: details.onStepContinue,
                              child: Text(
                                controller.currentStep.value ==
                                        formStep().length - 1
                                    ? "KIRIM"
                                    : 'Berikut',
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
                        )),
                      ),
                      SizedBox(width: 16),
                      if (controller.currentStep.value != 0)
                        Expanded(
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.only(top: 30, bottom: 40),
                            child: (Container(
                              child: ElevatedButton(
                                onPressed: details.onStepCancel,
                                child: Text(
                                  'Kembali',
                                  style: whiteTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: medium,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  backgroundColor: kRedColor,
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
        title: Text('Pemohon'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Formulir Pendaftaran Antrian Perekaman e-KTP',
                style: blackTextStyle.copyWith(
                  fontWeight: semiBold,
                ),
              ),
            ),
            SizedBox(height: 20.h),

            /// NIK
            CustomTitleWidget(tittle: 'NIK'),
            SizedBox(height: 12.h),
            CustomFormField(
              keyboardType: TextInputType.number,
              textEditingController: controller.nikC,
              validator: (value) {
                if (value!.isEmpty ||
                    !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]+$')
                        .hasMatch(value)) {
                  return "Masukan NIK yang benar";
                } else if (!GetUtils.isLengthEqualTo(value, 16)) {
                  return 'NIK harus 16 karakter';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 12.h),
            CustomTitleWidget(tittle: 'Nama Lengkap'),
            SizedBox(height: 12.h),
            CustomFormField(
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                    return "Masukan nama yang benar";
                  } else {
                    return null;
                  }
                },
                textEditingController: controller.nameC),

            SizedBox(height: 12.h),
            CustomTitleWidget(tittle: 'Tanggal lahir'),
            SizedBox(height: 12.h),
            TextFormField(
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
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),

            SizedBox(height: 12.h),

            /// Kecamatan
            CustomTitleWidget(tittle: 'Kecamatan'),
            SizedBox(height: 12.h),
            CustomFormField(
              keyboardType: TextInputType.name,
              textEditingController: controller.kecamatanC,
              onTap: () {},
              validator: (value) {
                if (!GetUtils.isEmail(value!)) {
                  return 'Email tidak valid';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 12.h),

            /// DESA
            CustomTitleWidget(tittle: 'Desa'),
            SizedBox(height: 12.h),
            CustomFormField(
              keyboardType: TextInputType.emailAddress,
              textEditingController: controller.emailC,
              validator: (value) {
                if (!GetUtils.isEmail(value!)) {
                  return 'Email tidak valid';
                } else {
                  return null;
                }
              },
            ),
          ],
        ),
        isActive: controller.currentStep.value >= 0,
        state:
            controller.currentStep > 0 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: Text('Persyaratan'),
        content: Container(
          height: 100,
          color: Colors.green,
        ),
        isActive: controller.currentStep.value >= 1,
      ),
    ];
  }
}
