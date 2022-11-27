import 'package:flutter/material.dart';
import '../shared/theme.dart';

class CustomDateInput extends StatelessWidget {
  final Function() onTap;
  final TextEditingController controller;
  const CustomDateInput({
    Key? key,
    required this.onTap,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: controller,
      readOnly: true,
      onTap: onTap,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Silahkan masukkan tanggal lahir';
        }
        return null;
      },
      decoration: InputDecoration(
        suffixIcon: Icon(
          Icons.calendar_month,
          color: kBlackColor,
        ),
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
