import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pemohon_dukcapil_app/app/shared/theme.dart';

import '../../../utils/custom_form_input.dart';
import '../../../utils/custom_tittle_form.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  @override
  Widget build(BuildContext context) {
    Widget resetPassword() {
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
              controller.reset();
            },
            child: Text(
              'Setel Ulang Sandi',
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
          title: Text('Ganti Sandi'),
        ),
        body: Form(
          key: controller.formKeys,
          child: ListView(
            padding: EdgeInsets.all(20),
            children: [
              /// Email
              SizedBox(height: 20.h),
              CustomTitleWidget(title: 'Email'),
              SizedBox(height: 12.h),
              CustomFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Input tidak boleh dikosongkan";
                  } else {
                    return null;
                  }
                },
                readOnly: false,
                textEditingController: controller.emailC,
                keyboardType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.words,
              ),
              SizedBox(height: 20),
              resetPassword()
            ],
          ),
        ));
  }
}
