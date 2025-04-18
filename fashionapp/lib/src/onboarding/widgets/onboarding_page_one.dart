import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/const/constants.dart';
import 'package:fashionapp/const/resource.dart';

class OnboardingScreenOne extends StatelessWidget {
  const OnboardingScreenOne({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      height: ScreenUtil().screenHeight,
      decoration: BoxDecoration(
        gradient: kGradient,
      ),
      child: Stack(
        children: [
          // Decorative shapes
          Positioned(
            top: -50,
            right: -30,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Kolors.kAccent.withOpacity(0.3),
              ),
            ),
          ),
          Positioned(
            bottom: -80,
            left: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Kolors.kPrimaryLight.withOpacity(0.4),
              ),
            ),
          ),

          // Main content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              // Image with shadow effect
              Container(
                width: ScreenUtil().screenWidth * 0.85,
                height: ScreenUtil().screenHeight * 0.45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Kolors.kDark.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    R.ASSETS_IMAGES_EXPERIENCE_PNG,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Spacer(),
              // Title
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text(
                  "Discover Latest Trends",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Kolors.kDark,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              // Description
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: BoxDecoration(
                  color: Kolors.kWhite.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Kolors.kDark.withOpacity(0.05),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: const Text(
                  AppText.kOnboardHome,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: Kolors.kGray,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ],
      ),
    );
  }
}
