import 'package:flutter/material.dart';

import '../shared/theme.dart';

class CustomTitleWidget extends StatelessWidget {
  final String tittle;
  const CustomTitleWidget({
    required this.tittle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      tittle,
      style: blackTextStyle.copyWith(
        fontSize: 16,
        fontWeight: medium,
      ),
    );
  }
}
