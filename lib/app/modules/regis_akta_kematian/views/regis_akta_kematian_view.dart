import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
        (() => Stepper(
              elevation: 1,
              type: StepperType.horizontal,
              steps: formStep(),
              onStepContinue: () {
                if (!controller.formKeys[controller.index].currentState!
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
                  child: Row(
                    children: [
                      Expanded(
                        child: (Container(
                          height: 50,
                          width: 80,
                          margin:
                              EdgeInsets.only(top: 30, bottom: 40, left: 20),
                          child: (Container(
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
        title: Text('Pemohon'),
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
                  key: controller.formKeys[0],
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

                      /// NO KK
                      CustomTitleWidget(tittle: 'NO KK'),
                      SizedBox(height: 12.h),
                      CustomFormField(
                        readOnly: false,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        textEditingController: controller.noKKC,
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]+$')
                                  .hasMatch(value)) {
                            return "Masukan Nomor KK yang benar";
                          } else if (!GetUtils.isLengthEqualTo(value, 16)) {
                            return 'NIK harus 16 karakter';
                          }
                        },
                      ),
                      SizedBox(height: 12.h),

                      /// NIK
                      CustomTitleWidget(tittle: 'NIK'),
                      SizedBox(height: 12.h),
                      CustomFormField(
                        readOnly: true,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        textEditingController: controller.nikC,
                      ),

                      SizedBox(height: 12.h),
                      CustomTitleWidget(tittle: 'Nama Lengkap'),
                      SizedBox(height: 12.h),
                      CustomFormField(
                          readOnly: true,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
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
                          if (value!.isEmpty) {
                            return 'Masukan tanggal lahir';
                          } else {
                            return null;
                          }
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
                      ),
                      SizedBox(height: 12.h),

                      /// DESA
                      CustomTitleWidget(tittle: 'Desa'),
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
        title: Text('Persyaratan'),
        content: Form(
          key: controller.formKeys[1],
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// FOTO KK
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
                        GetBuilder<PerubahanKtpController>(
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
                            GestureDetector(
                              child: Container(
                                width: 120.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: GetBuilder<PerubahanKtpController>(
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
                SizedBox(
                  height: 12,
                ),

                // /// FOTO KTP
                Text(
                  'Unggah KTP/SURAT KETERANGAN KEHILANGAN',
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
                        GetBuilder<PerubahanKtpController>(
                          builder: (c) => c.pickedImageKTP != null
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        c.pickedImageKTP!.name,
                                        style: blackTextStyle.copyWith(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () => c.resetImageKTP(),
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
                                child: GetBuilder<PerubahanKtpController>(
                                  builder: (c) {
                                    return c.pickedImageKTP != null
                                        ? ElevatedButton(
                                            onPressed: () {
                                              Get.dialog(
                                                Container(
                                                  child: PhotoView(
                                                    imageProvider: FileImage(
                                                      File(c.pickedImageKTP!
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
                                  controller.selectImageKTP();
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

                SizedBox(height: 12.h),
              ],
            ),
          ),
        ),
        isActive: controller.currentStep.value >= 1,
      ),
    ];
  }
}
