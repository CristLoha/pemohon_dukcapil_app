import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pemohon_dukcapil_app/app/modules/register/controllers/register_controller.dart';
import '../shared/theme.dart';

class CustomFormField extends GetView<RegisterController> {
  final TextInputType? keyboardType;
  final Icon? icon;
  final double? maxLines;
  final bool? readOnly;
  final TextInputAction? textInputAction;
  final Function()? onTap;
  final String? Function(String?)? validator;
  final TextEditingController textEditingController;

  const CustomFormField(
      {Key? key,
      this.keyboardType,
      this.icon,
      this.maxLines,
      this.textInputAction,
      this.readOnly,
      this.onTap,
      this.validator,
      required this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // textCapitalization: TextCapitalization.words,
      textInputAction: textInputAction,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      cursorColor: kGreyColor,
      onTap: onTap,
      readOnly: readOnly!,
      keyboardType: keyboardType,
      autocorrect: false,
      controller: textEditingController,
      decoration: InputDecoration(
        prefixIcon: icon,
        hintStyle: greyTextStyle,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }
}
