import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
        child: Form(
          key: controller.formKeys,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// NAMA
              CustomTitleWidget(title: 'Nama Lengkap'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textInputAction: TextInputAction.next,
                icon: Icon(
                  Icons.person,
                  color: kBlackColor,
                ),
                keyboardType: TextInputType.name,
                textEditingController: controller.nameC,
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                    return "Masukan nama yang benar";
                  } else {
                    return null;
                  }
                },
                textCapitalization: TextCapitalization.words,
              ),
              SizedBox(height: 20.h),

              /// NIK
              CustomTitleWidget(title: 'NIK'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textInputAction: TextInputAction.next,
                icon: Icon(
                  FontAwesome5.id_card,
                  color: kBlackColor,
                ),
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
                textCapitalization: TextCapitalization.none,
              ),
              SizedBox(height: 20.h),

              /// Jenis Kelamin
              CustomTitleWidget(title: 'Jenis Kelamin'),
              SizedBox(height: 12.h),
              DropdownSearch<Map<String, dynamic>>(
                dialogMaxWidth: 8,
                mode: Mode.MENU,
                items: controller.dataJenisKelamin,
                dropdownButtonSplashRadius: 10,
                dropdownBuilder: (context, selectedItem) => Text(
                  selectedItem?["jenisKelamin"].toString() ?? "PILIH",
                  style: blackTextStyle,
                ),
                popupItemBuilder: (context, item, isSelected) => ListTile(
                  title: Text(
                    item["jenisKelamin"].toString(),
                    style: blackTextStyle,
                  ),
                ),
                showClearButton: true,
                onChanged: (value) {
                  print(value!["jenisKelamin"]);
                  controller.jenisKelaminC =
                      TextEditingController(text: value["jenisKelamin"]);
                },
              ),
              SizedBox(height: 20.h),

              /// EMAIL
              CustomTitleWidget(title: 'Email'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textInputAction: TextInputAction.next,
                icon: Icon(
                  ModernPictograms.at,
                  color: kBlackColor,
                ),
                keyboardType: TextInputType.emailAddress,
                textEditingController: controller.emailC,
                validator: (value) {
                  if (!GetUtils.isEmail(value!)) {
                    return 'Email tidak valid';
                  } else {
                    return null;
                  }
                },
                textCapitalization: TextCapitalization.none,
              ),

              SizedBox(height: 20.h),

              /// Nomor Telepon
              CustomTitleWidget(title: 'Nomor Telepon'),
              SizedBox(height: 12.h),
              CustomFormField(
                readOnly: false,
                textInputAction: TextInputAction.next,
                icon: Icon(
                  FontAwesome.phone,
                  color: kBlackColor,
                ),
                keyboardType: TextInputType.phone,
                textEditingController: controller.noTelpC,
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]+$')
                          .hasMatch(value)) {
                    return "Masukan nomor telepon yang benar";
                  } else if (!GetUtils.isLengthGreaterOrEqual(value, 11)) {
                    return 'Minimal 12 karakter';
                  } else {
                    return null;
                  }
                },
                textCapitalization: TextCapitalization.none,
              ),

              SizedBox(height: 20.h),
              CustomTitleWidget(title: 'Kata Sandi'),
              SizedBox(height: 12.h),
              Obx(
                () => TextFormField(
                  readOnly: false,
                  textInputAction: TextInputAction.done,
                  cursorColor: kGreyColor,
                  obscureText: controller.isHidden.value,
                  keyboardType: TextInputType.visiblePassword,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (!GetUtils.isLengthGreaterThan(value, 5)) {
                      return 'Minimal 5 karakter';
                    } else {
                      return null;
                    }
                  },
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
        ),
      );
    }

    Widget butonRegister() {
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
              controller.register();
            },
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
