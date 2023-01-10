import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/font_awesome_icons.dart';

import 'package:get/get.dart';
import 'package:pemohon_dukcapil_app/app/shared/theme.dart';

import '../../../utils/custom_form_input.dart';
import '../../../utils/custom_tittle_form.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    Widget buttonUpdate() {
      return Container(
        height: 50.h,
        margin: EdgeInsets.only(top: 30.h),
        child: Container(
          child: ElevatedButton(
            onPressed: () async {
              await EasyLoading.show(status: 'memuat...');
              controller.updateProfile();
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Profile Berhasil Diperbaharui');
              Get.back();
            },
            child: Text(
              'Perbarui Profile',
              style: whiteTextStyle.copyWith(
                fontSize: 16.sp,
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
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text('Profile'),
        ),
        body: FutureBuilder<Map<String, dynamic>?>(
            future: controller.getProfile(),
            builder: (context, snapshot) {
              // if (snapshot.connectionState == ConnectionState.waiting) {
              //   return Center(
              //     child: CircularProgressIndicator(),
              //   );
              // }
              if (snapshot.data == null) {
                return Center(
                  child: Text('Tidak ada data dari pengguna'),
                );
              } else {
                controller.nameC.text = snapshot.data!['nama'];
                controller.noTelpC.text = snapshot.data!['nomor_telp'];
                controller.jenisKelaminC.text = snapshot.data!['jenisKelamin'];
                controller.nikC.text = snapshot.data!['nik'];
                controller.emailC.text = snapshot.data!['email'];

                return ListView(
                  padding: EdgeInsets.all(20),
                  children: [
                    /// Nama Lengkap
                    CustomTitleWidget(title: 'Nama Lengkap'),
                    SizedBox(height: 12.h),
                    CustomFormField(
                        textCapitalization: TextCapitalization.words,
                        readOnly: false,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        textEditingController: controller.nameC),
                    SizedBox(height: 20.h),

                    /// Nik
                    CustomTitleWidget(title: 'NIK'),
                    SizedBox(height: 12.h),
                    CustomFormField(
                        textCapitalization: TextCapitalization.words,
                        readOnly: false,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        textEditingController: controller.nikC),
                    SizedBox(height: 20.h),

                    /// JenisKelamin
                    CustomTitleWidget(title: 'Jenis Kelamin'),
                    SizedBox(height: 12.h),
                    CustomFormField(
                        textCapitalization: TextCapitalization.words,
                        readOnly: false,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        textEditingController: controller.jenisKelaminC),
                    SizedBox(height: 20.h),

                    /// Email
                    CustomTitleWidget(title: 'Email'),
                    SizedBox(height: 12.h),
                    CustomFormField(
                        textCapitalization: TextCapitalization.words,
                        readOnly: true,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        textEditingController: controller.emailC),
                    SizedBox(height: 20.h),

                    /// Nomor Telepon
                    CustomTitleWidget(title: 'Nomor Telepon'),
                    SizedBox(height: 12.h),
                    CustomFormField(
                        textCapitalization: TextCapitalization.words,
                        readOnly: false,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        textEditingController: controller.noTelpC),
                    SizedBox(height: 20.h),

                    /// Kata Sandi
                    CustomTitleWidget(title: 'Kata Sandi'),
                    SizedBox(height: 12.h),
                    Obx(
                      () => TextFormField(
                        textInputAction: TextInputAction.none,
                        cursorColor: kGreyColor,
                        obscureText: controller.isHidden.value,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.visiblePassword,
                        autocorrect: false,
                        controller: controller.passC,
                        decoration: InputDecoration(
                          hintText: 'Kata Sandi Baru',
                          suffixIcon: IconButton(
                            onPressed: () => controller.isHidden.toggle(),
                            icon: controller.isHidden.isFalse
                                ? Icon(
                                    FontAwesome.eye,
                                    color: kBlackColor,
                                  )
                                : Icon(
                                    FontAwesome.eye_off,
                                    color: kBlackColor,
                                  ),
                          ),
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
                    ),
                    SizedBox(height: 40.h),
                    buttonUpdate(),
                  ],
                );
              }
            }));
  }
}
