import 'package:flutter/material.dart';

import '../shared/theme.dart';

class CustomTitleWidget extends StatelessWidget {
  final String title;
  const CustomTitleWidget({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: blackTextStyle.copyWith(
        fontSize: 16,
        fontWeight: medium,
      ),
    );
  }
}
