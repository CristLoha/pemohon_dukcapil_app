import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../shared/theme.dart';

class CustomOutputForm extends StatelessWidget {
  final String title;
  final String subtitle;
  const CustomOutputForm({
    required this.title,
    required this.subtitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: Get.width * 6,
          decoration: BoxDecoration(
              color: Color(0xffE9E4F3), borderRadius: BorderRadius.circular(4)),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              title,
              style: blackTextStyle.copyWith(
                fontWeight: medium,
                fontSize: 12,
              ),
            ),
          ),
        ),
        Text(
          subtitle,
          style: blackTextStyle.copyWith(fontSize: 12),
        )
      ],
    );
  }
}
