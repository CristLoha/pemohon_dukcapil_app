import 'package:flutter/material.dart';

import '../shared/theme.dart';

class DigitalClockWidget extends StatelessWidget {
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final Icon? icon;
  final double? maxLines;

  final TextInputAction? textInputAction;
  final Function()? onTap;
  final String? Function(String?)? validator;
  final TextEditingController textEditingController;
  const DigitalClockWidget(
      {Key? key,
      this.keyboardType,
      this.icon,
      this.maxLines,
      required this.textCapitalization,
      this.textInputAction,
      this.onTap,
      this.validator,
      required this.textEditingController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      cursorColor: kGreyColor,
      onTap: onTap,
      keyboardType: keyboardType,
      autocorrect: false,
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: '07:00',
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
