import 'package:flutter/material.dart';
import '../shared/theme.dart';

class CustomFormField extends StatelessWidget {
  final TextInputType keyboardType;
  final Icon icon;
  final TextEditingController textEditingController;

  const CustomFormField(
      {Key? key,
      required this.keyboardType,
      required this.icon,
      required this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
