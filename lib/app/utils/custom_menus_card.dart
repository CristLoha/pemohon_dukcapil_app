import 'package:flutter/material.dart';
import '../shared/theme.dart';

class CustomMenusCard extends StatelessWidget {
  final String icon;
  final String title;
  final double height;
  final double bottom;
  final double widthIcon;
  final Function() onTap;
  const CustomMenusCard({
    required this.icon,
    required this.title,
    required this.height,
    required this.onTap,
    required this.bottom,
    required this.widthIcon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: bottom),
            child: Image.asset(
              icon,
              width: widthIcon,
            ),
          ),
          Text(
            title,
            style: blackTextStyle.copyWith(
              fontSize: height,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
