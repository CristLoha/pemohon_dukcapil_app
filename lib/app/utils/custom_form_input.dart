import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pemohon_dukcapil_app/app/modules/register/controllers/register_controller.dart';
import '../shared/theme.dart';

class CustomFormField extends GetView<RegisterController> {
  final TextInputType keyboardType;
  final Icon icon;
  final String? Function(String?)? validator;
  final TextEditingController textEditingController;

  const CustomFormField(
      {Key? key,
      required this.keyboardType,
      required this.icon,
      required this.validator,
      required this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      cursorColor: kGreyColor,
      keyboardType: keyboardType,
      autocorrect: false,
      controller: textEditingController,
      decoration: InputDecoration(
        prefixIcon: icon,
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
    );
  }
}
