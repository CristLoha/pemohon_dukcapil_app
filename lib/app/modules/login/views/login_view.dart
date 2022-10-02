import 'package:flutter/material.dart';
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
    Widget titleWelcome() {
      return Container(
        margin: EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/img/logo.png',
              height: 80,
            ),
            SizedBox(height: 20),
            Text(
              'Selamat Datang',
              style: blackTextStyle.copyWith(
                  fontSize: 24, fontWeight: semiBold, letterSpacing: 1),
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
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTitleWidget(tittle: 'Email'),
            SizedBox(height: 12),
            TextFormField(
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
                hintText: 'Masukan Email',
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
            SizedBox(height: 20),
            CustomTitleWidget(tittle: 'Kata Sandi'),
            SizedBox(height: 12),
            Obx(
              () => TextFormField(
                cursorColor: kGreyColor,
                obscureText: controller.isHidden.value,
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
                    Icons.lock_outline,
                    color: kBlackColor,
                  ),
                  hintStyle: greyTextStyle,
                  hintText: 'Masukan kata sandi',
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
                    fontSize: 14,
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
        height: 50,
        margin: EdgeInsets.only(top: 30),
        child: Container(
          child: ElevatedButton(
            onPressed: () => Get.toNamed(Routes.HOME),
            child: Text(
              'Masuk',
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
        ),
      );
    }

    Widget register() {
      return Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Belum punya akun?',
              style: greyTextStyle,
            ),
            SizedBox(width: 4),
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
