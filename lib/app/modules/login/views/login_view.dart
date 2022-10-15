import 'package:flutter/material.dart';
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
              'Isi Data Pribadi Anda ',
              style: greyTextStyle,
            ),
          ],
        ),
      );
    }

    Widget formLogin() {
      return Container(
        margin: EdgeInsets.only(top: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTitleWidget(tittle: 'Email'),
            SizedBox(height: 12.h),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (!GetUtils.isEmail(value!)) {
                  return 'Email tidak valid';
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
            CustomTitleWidget(tittle: 'Kata Sandi'),
            SizedBox(height: 12.h),
            Obx(
              () => TextFormField(
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
                value: controller.isSelected.value,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  controller.isSelected.toggle();
                },
                title: Text(
                  'Ingat Saya',
                  style: blackTextStyle.copyWith(
                    fontSize: 14.sp,
                  ),
                ),
                secondary: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Lupa Kata Sandi?',
                    style: blueTextStyle.copyWith(fontWeight: semiBold),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget butonLogin() {
      return Container(
        height: 50.h,
        margin: EdgeInsets.only(top: 30.h),
        child: Container(
          child: Obx(
            () => ElevatedButton(
              onPressed: () {
                controller.login();
              },
              child: Text(
                controller.isLoading.isFalse ? 'Masuk' : 'Memuat...',
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
                'REGISTRASI',
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
