import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/const/resource.dart';

class OnboardingScreenTwo extends StatelessWidget {
  const OnboardingScreenTwo({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      height: ScreenUtil().screenHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Kolors.kAccent2,
            Kolors.kSecondaryLight,
            Kolors.kAccent.withOpacity(0.8),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Decorative elements
          Positioned(
            top: 60,
            left: -30,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Kolors.kPrimary.withOpacity(0.3),
              ),
            ),
          ),
          Positioned(
            bottom: 120,
            right: -60,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Kolors.kAccent.withOpacity(0.25),
              ),
            ),
          ),

          // Main content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              // Title
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text(
                  "Find Your Favorites",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Kolors.kDark,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
              // Image with refined design
              Container(
                width: ScreenUtil().screenWidth * 0.85,
                height: ScreenUtil().screenHeight * 0.45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Kolors.kDark.withOpacity(0.08),
                      blurRadius: 20,
                      spreadRadius: 2,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    R.ASSETS_IMAGES_WISHLIST_PNG,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Spacer(),
              // Description in a styled container
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                decoration: BoxDecoration(
                  color: Kolors.kWhite.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Kolors.kDark.withOpacity(0.05),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: const Column(
                  children: [
                    Text(
                      "Save Your Favorites",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Kolors.kDark,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      AppText.kOnboardWishListMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Kolors.kGray,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
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
