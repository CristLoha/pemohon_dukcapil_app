import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pemohon_dukcapil_app/app/modules/register/controllers/register_controller.dart';
import '../shared/theme.dart';

class CustomFormKeteranganField extends GetView<RegisterController> {
  final Icon? icon;
  final double? maxLines;
  final bool? readOnly;
  final String? hintText;

  final TextInputAction? textInputAction;
  final Function()? onTap;

  final TextEditingController textEditingController;

  const CustomFormKeteranganField(
      {Key? key,
      this.icon,
      this.maxLines,
      this.hintText,
      this.textInputAction,
      this.readOnly,
      this.onTap,
      required this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: 5,
      minLines: 1,
      cursorColor: kGreyColor,
      onTap: onTap,
      readOnly: readOnly!,
      keyboardType: TextInputType.multiline,
      autocorrect: true,
      controller: textEditingController,
      decoration: InputDecoration(
        prefixIcon: icon,
        hintText: hintText,
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
