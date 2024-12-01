import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/back_button.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PolicyPage extends StatelessWidget {
  const PolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        centerTitle: true,
        title: ReusableText(
          text: AppText.kPolicy,
          style: appStyle(16, Kolors.kPrimary, FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: ListView(
          children: [
            SizedBox(
              height: 12.h,
            ),
            ReusableText(
              text: AppText.kCancelation,
              style: appStyle(15, Kolors.kPrimary, FontWeight.w500),
            ),
            SizedBox(
              height: 12.h,
            ),
            Text(
              AppText.kAppCancelationPolicy,
              textAlign: TextAlign.justify,
              style: appStyle(13, Kolors.kGray, FontWeight.normal),
            ),
            SizedBox(
              height: 12.h,
            ),
            ReusableText(
              text: AppText.kTerms,
              style: appStyle(15, Kolors.kPrimary, FontWeight.w500),
            ),
            SizedBox(
              height: 12.h,
            ),
            Text(
              AppText.kAppTerms,
              textAlign: TextAlign.justify,
              style: appStyle(13, Kolors.kGray, FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
