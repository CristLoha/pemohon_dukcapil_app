import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pemohon_dukcapil_app/app/shared/theme.dart';

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
                          margin: EdgeInsets.only(top: 30, bottom: 40),
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
                                  style: blackTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: medium,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
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
        title: Text('e-KTP'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Formulir Perekaman e-KTP'),
            Container(
              height: 100,
              color: Colors.red,
            ),
          ],
        ),
        isActive: controller.currentStep.value >= 0,
        state:
            controller.currentStep > 0 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: Text('Pemohon'),
        content: Container(
          height: 100,
          color: Colors.yellow,
        ),
        isActive: controller.currentStep.value >= 1,
        state:
            controller.currentStep > 1 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: Text('Persyaratan'),
        content: Container(
          height: 100,
          color: Colors.green,
        ),
        isActive: controller.currentStep.value >= 2,
      ),
    ];
  }
}
