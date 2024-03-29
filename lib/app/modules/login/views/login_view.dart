import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/modern_pictograms_icons.dart';
import 'package:get/get.dart';
import 'package:pemohon_dukcapil_app/app/routes/app_pages.dart';

import '../../../shared/theme.dart';
import '../../../utils/custom_tittle_form.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    if (controller.box.read("tetapmasuk") != null) {
      controller.emailC.text = controller.box.read("tetapmasuk")["email"];
      controller.passC.text = controller.box.read("tetapmasuk")["pass"];
      controller.rememberMe.value = true;
    }
    ScreenUtil.init(context, designSize: const Size(360, 690));
    Widget titleWelcome() {
      return Container(
        margin: EdgeInsets.only(top: 80.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/img/logo.png',
              height: 85.h,
            ),
            SizedBox(height: 20.h),
            Text(
              'Selamat Datang',
              style: blackTextStyle.copyWith(
                  fontSize: 24.sp, fontWeight: semiBold, letterSpacing: 1),
            ),
            Text(
              'Silakan masukkan email dan kata sandi Anda untuk masuk',
              style: greyTextStyle,
            ),
          ],
        ),
      );
    }

    Widget formLogin() {
      return Container(
        margin: EdgeInsets.only(top: 20.h),
        child: Form(
          key: controller.formKeys,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// EMAIL
              CustomTitleWidget(title: 'Email'),
              SizedBox(height: 12.h),
              TextFormField(
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                          .hasMatch(value)) {
                    return "Email tidak valid";
                  } else {
                    return null;
                  }
                },
                cursorColor: kGreyColor,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                controller: controller.emailC,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    ModernPictograms.at,
                    color: kBlackColor,
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
              SizedBox(height: 20.h),
              CustomTitleWidget(title: 'Kata Sandi'),
              SizedBox(height: 12.h),
              Obx(
                () => TextFormField(
                  textInputAction: TextInputAction.none,
                  cursorColor: kGreyColor,
                  obscureText: controller.isHidden.value,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (!GetUtils.isLengthGreaterThan(value, 5)) {
                      return 'Minimal 5 karakter';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.visiblePassword,
                  autocorrect: false,
                  controller: controller.passC,
                  decoration: InputDecoration(
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
                    prefixIcon: Icon(
                      Icons.lock,
                      color: kBlackColor,
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
              Obx(
                () => CheckboxListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  activeColor: kPrimaryColor,
                  value: controller.rememberMe.value,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (_) => controller.rememberMe.toggle(),
                  title: Text(
                    'tetap masuk',
                    style: blackTextStyle.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                  secondary: TextButton(
                    onPressed: () => Get.toNamed(Routes.RESET_PASSWORD),
                    child: Text(
                      'Lupa Sandi?',
                      style: blueTextStyle.copyWith(fontWeight: semiBold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget butonLogin() {
      return Container(
        height: 50.h,
        margin: EdgeInsets.only(top: 30.h),
        child: Container(
          child: ElevatedButton(
            onPressed: () {
              if (!controller.formKeys.currentState!.validate()) {
                return;
              }
              EasyLoading.show(status: 'memuat...');
              controller.login();
            },
            child: Text(
              'Masuk',
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

    Widget register() {
      return Padding(
        padding: EdgeInsets.only(top: 5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Belum punya akun?',
              style: greyTextStyle,
            ),
            SizedBox(width: 4.w),
            TextButton(
              onPressed: () => Get.toNamed(
                Routes.REGISTER,
              ),
              child: Text(
                'Daftar sekarang!',
                style: blueTextStyle.copyWith(
                  fontWeight: semiBold,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(
            top: defaultPadding,
            left: defaultPadding,
            right: defaultPadding,
            bottom: defaultPadding),
        children: [
          titleWelcome(),
          formLogin(),
          butonLogin(),
          register(),
        ],
      ),
    );
  }
}
