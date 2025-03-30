// ignore_for_file: unnecessary_null_in_if_null_operators
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({
    super.key,
    required this.text,
    this.style,
    this.divider,
    this.isSelected = false,
  });

  final String text;
  final TextStyle? style;
  final double? divider;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      height: 35.h,
      decoration: BoxDecoration(
        color: isSelected ? Kolors.kPrimary : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: isSelected
            ? null
            : Border.all(color: Kolors.kGrayLight.withOpacity(0.5), width: 1),
      ),
      child: Center(
        child: Text(
          text,
          style: style ??
              TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? Kolors.kWhite : Kolors.kGray,
              ),
        ),
      ),
    );
  }
}
