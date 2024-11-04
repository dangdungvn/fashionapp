import 'package:myapp/common/utils/kcolors.dart';
import 'package:myapp/common/widgets/app_style.dart';
import 'package:myapp/common/widgets/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradientBtn extends StatelessWidget {
  const GradientBtn({
    super.key,
    this.onTap,
    this.btnWidth,
    required this.text,
    this.btnHieght,
    this.textSize,
    this.borderColor,
    this.radius,
    this.btnColor,
  });
  final void Function()? onTap;
  final double? btnWidth;
  final double? btnHieght;
  final double? radius;
  final String text;
  final double? textSize;
  final Color? borderColor;
  final Color? btnColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: btnWidth ?? ScreenUtil().screenWidth / 2,
        height: btnHieght ?? 25.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 6),
          color: btnColor ?? Kolors.kPrimaryLight,
          border: Border.all(width: 0.5.h, color: borderColor ?? Kolors.kWhite),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: ReusableText(
                text: text,
                style: appStyle(textSize ?? 13, borderColor ?? Kolors.kWhite,
                    FontWeight.w500)),
          ),
        ),
      ),
    );
  }
}
