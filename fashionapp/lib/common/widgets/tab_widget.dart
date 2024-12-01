// ignore_for_file: unnecessary_null_in_if_null_operators

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({super.key, required this.text, this.style, this.divider});

  final String text;
  final TextStyle? style;
  final double? divider;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      width: divider?? ScreenUtil().screenWidth /5,
      height: 18,
      child: Center(
          child: Text(
        text,
        style: style ?? null,
      )),
    );
  }
}
