import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pemohon_dukcapil_app/app/shared/theme.dart';

import '../../../utils/custom_form_input.dart';
import '../../../utils/custom_tittle_form.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text('Ganti Kata Sandi'),
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            /// Email
            SizedBox(height: 20.h),
            CustomTitleWidget(title: 'Emaill'),
            SizedBox(height: 12.h),
            CustomFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Input tidak boleh kosong";
                } else {
                  return null;
                }
              },
              readOnly: false,
              textEditingController: controller.emailC,
              keyboardType: TextInputType.emailAddress,
              textCapitalization: TextCapitalization.words,
            ),
          ],
        ));
  }
}
