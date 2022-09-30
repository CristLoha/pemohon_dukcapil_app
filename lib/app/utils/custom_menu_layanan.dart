import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../shared/theme.dart';

class CustomMenuLayanan extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final String icon;

  const CustomMenuLayanan({
    required this.title,
    required this.icon,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: kBlueColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset(
                icon,
                color: kPrimaryColor,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: blueTextStyle.copyWith(
              fontWeight: semiBold,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
