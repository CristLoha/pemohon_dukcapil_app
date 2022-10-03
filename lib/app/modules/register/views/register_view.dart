import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/modern_pictograms_icons.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/theme.dart';
import '../../../utils/custom_form_input.dart';
import '../../../utils/custom_tittle_form.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    Widget titleNotice() {
      return Container(
        margin: EdgeInsets.only(top: 40.h),
        child: Row(
          children: [
            Image.asset(
              'assets/icon/megaphone.png',
              fit: BoxFit.cover,
              width: 40.h,
            ),
            SizedBox(width: 8.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Silahkan diisi Data dengan Benar!',
                    style: greyTextStyle.copyWith(fontSize: 13.sp),
                  ),
                  Text(
                    'Verifikasi membutuhkan waktu maksimal 1x24 jam',
                    style: redTextStyle.copyWith(
                      fontSize: 13.sp,
                      fontWeight: semiBold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget formRegister() {
      return Container(
        margin: EdgeInsets.only(top: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// NAMA
            CustomTitleWidget(tittle: 'Nama Lengkap'),
            SizedBox(height: 12.h),
            CustomFormField(
              icon: Icon(
                Icons.person,
                color: kBlackColor,
              ),
              keyboardType: TextInputType.name,
              textEditingController: controller.nameC,
            ),
            SizedBox(height: 20.h),

            /// NIK
            CustomTitleWidget(tittle: 'NIK'),
            SizedBox(height: 12.h),
            CustomFormField(
              icon: Icon(
                FontAwesome5.id_card,
                color: kBlackColor,
              ),
              keyboardType: TextInputType.number,
              textEditingController: controller.nikC,
            ),
            SizedBox(height: 20.h),

            /// EMAIL
            CustomTitleWidget(tittle: 'Email'),
            SizedBox(height: 12.h),
            CustomFormField(
              icon: Icon(
                ModernPictograms.at,
                color: kBlackColor,
              ),
              keyboardType: TextInputType.emailAddress,
              textEditingController: controller.emailC,
            ),

            SizedBox(height: 20.h),

            /// EMAIL
            CustomTitleWidget(tittle: 'Nomor Telepon'),
            SizedBox(height: 12.h),
            CustomFormField(
              icon: Icon(
                FontAwesome.phone,
                color: kBlackColor,
              ),
              keyboardType: TextInputType.phone,
              textEditingController: controller.emailC,
            ),

            SizedBox(height: 20.h),
            CustomTitleWidget(tittle: 'Kata Sandi'),
            SizedBox(height: 12.h),
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
          ],
        ),
      );
    }

    Widget butonRegister() {
      return Container(
        height: 50.h,
        margin: EdgeInsets.only(top: 30.h),
        child: Container(
          child: ElevatedButton(
            onPressed: () => Get.offAllNamed(Routes.MAIN_PAGE),
            child: Text(
              'Daftar',
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

    Widget login() {
      return Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sudah punya akun?',
              style: greyTextStyle,
            ),
            SizedBox(width: 2.h),
            TextButton(
              onPressed: () => Get.toNamed(
                Routes.LOGIN,
              ),
              child: Text(
                'LOGIN',
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
          titleNotice(),
          formRegister(),
          butonRegister(),
          login(),
        ],
      ),
    );
  }
}
