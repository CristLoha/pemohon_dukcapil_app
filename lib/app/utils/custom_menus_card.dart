import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../shared/theme.dart';

class CustomMenusCard extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final String icon;
  final String title;
  final double height;
  final double widthIcon;
  const CustomMenusCard({
    required this.padding,
    required this.icon,
    required this.title,
    required this.height,
    required this.widthIcon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: height),
            child: Image.asset(
              icon,
              width: widthIcon,
            ),
          ),
          Text(
            title,
            style: blackTextStyle.copyWith(
              fontSize: 11,
              fontWeight: medium,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
