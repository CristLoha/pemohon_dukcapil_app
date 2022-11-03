import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../shared/theme.dart';

class BottomBar extends StatelessWidget {
  final Function() onPressed;
  final bool bottomIcons;
  final IconData icons;
  final IconData icons2;
  final String text;
  const BottomBar(
      {required this.onPressed,
      required this.bottomIcons,
      required this.icons,
      required this.icons2,
      required this.text,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: bottomIcons == true
          ? Container(
              decoration: BoxDecoration(
                color: kBlueColor,
                borderRadius: BorderRadius.circular(30),
              ),
              padding:
                  EdgeInsets.only(left: 14.w, right: 14, top: 6, bottom: 6),
              child: Container(
                child: Row(
                  children: [
                    Icon(
                      icons,
                      color: kPrimaryColor,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      text,
                      style: blueTextStyle.copyWith(
                        fontWeight: bold,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Icon(icons2),
    );
  }
}
