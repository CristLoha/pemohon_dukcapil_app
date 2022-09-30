import 'package:flutter/material.dart';
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
    return GestureDetector(
      onTap: onPressed,
      child: bottomIcons == true
          ? Container(
              decoration: BoxDecoration(
                color: kBlueColor,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              child: Row(
                children: [
                  Icon(
                    icons,
                    color: kPrimaryColor,
                  ),
                  SizedBox(width: 8),
                  Text(
                    text,
                    style: blueTextStyle.copyWith(
                      fontWeight: bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            )
          : Icon(icons2),
    );
  }
}
