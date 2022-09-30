import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../shared/theme.dart';
import '../../../utils/custom_tittle_form.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    Widget titleWelcome() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/img/logo.png',
              height: 65,
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
              keyboardType: TextInputType.number,
              autocorrect: false,
              controller: controller.emailC,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person_outlined,
                  color: kBlackColor,
                ),
                hintStyle: greyTextStyle,
                hintText: 'Masukan Email anda',
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
                autocorrect: false,
                controller: controller.passC,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () => controller.isHidden.toggle(),
                    icon: controller.isHidden.isFalse
                        ? Icon(
                            Icons.remove_red_eye_outlined,
                            color: kBlackColor,
                          )
                        : Icon(
                            Icons.remove_red_eye_rounded,
                            color: kBlackColor,
                          ),
                  ),
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: kBlackColor,
                  ),
                  hintStyle: greyTextStyle,
                  hintText: 'Masukan kata sandi anda',
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
                activeColor: kPrimaryColor,
                value: controller.isSelected.value,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  controller.isSelected.toggle();
                },
                title: Text(
                  'Ingat Saya',
                  style: blackTextStyle.copyWith(fontSize: 14),
                ),
                secondary: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Lupa Kata Sandi?',
                    style: blueTextStyle,
                  ),
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
        ),
        children: [
          titleWelcome(),
          formLogin(),
        ],
      ),
    );
  }
}
