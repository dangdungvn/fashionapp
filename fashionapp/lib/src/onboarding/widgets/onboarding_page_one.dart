import 'package:flutter/material.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/const/constants.dart';
import 'package:fashionapp/const/resource.dart';

class OnboardingScreenOne extends StatelessWidget {
  const OnboardingScreenOne({super.key});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bool isSmallScreen = screenHeight < 700;

    return Container(
      width: screenWidth,
      height: screenHeight,
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
              width: screenWidth * 0.45,
              height: screenWidth * 0.45,
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
              width: screenWidth * 0.55,
              height: screenWidth * 0.55,
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
              SizedBox(height: isSmallScreen ? 30 : 40),
              // Image with shadow effect
              Container(
                width: screenWidth * 0.85,
                height: screenHeight * (isSmallScreen ? 0.40 : 0.45),
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
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Text(
                  "Discover Latest Trends",
                  style: TextStyle(
                    fontSize: isSmallScreen ? 26 : 28,
                    fontWeight: FontWeight.bold,
                    color: Kolors.kDark,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: isSmallScreen ? 15 : 20),
              // Description
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: isSmallScreen ? 20 : 30,
                ),
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
                child: Text(
                  AppText.kOnboardHome,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 15 : 16,
                    height: 1.5,
                    color: Kolors.kGray,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: isSmallScreen ? 65 : 80),
            ],
          ),
        ],
      ),
    );
  }
}
