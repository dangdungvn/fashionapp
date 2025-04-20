import 'package:flutter/material.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/const/resource.dart';

class OnboardingScreenTwo extends StatelessWidget {
  const OnboardingScreenTwo({super.key});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bool isSmallScreen = screenHeight < 700;

    return Container(
      width: screenWidth,
      height: screenHeight,
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
              width: screenWidth * 0.35,
              height: screenWidth * 0.35,
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
              width: screenWidth * 0.4,
              height: screenWidth * 0.4,
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
              SizedBox(height: isSmallScreen ? 20 : 30),
              // Title
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Text(
                  "Find Your Favorites",
                  style: TextStyle(
                    fontSize: isSmallScreen ? 26 : 28,
                    fontWeight: FontWeight.bold,
                    color: Kolors.kDark,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: isSmallScreen ? 20 : 30),
              // Image with refined design
              Container(
                width: screenWidth * 0.85,
                height: screenHeight * (isSmallScreen ? 0.40 : 0.45),
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
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.06,
                  vertical: isSmallScreen ? 20 : 30,
                ),
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
                child: Column(
                  children: [
                    Text(
                      "Save Your Favorites",
                      style: TextStyle(
                        fontSize: isSmallScreen ? 17 : 18,
                        fontWeight: FontWeight.w600,
                        color: Kolors.kDark,
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 8 : 10),
                    Text(
                      AppText.kOnboardWishListMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 15 : 16,
                        height: 1.5,
                        color: Kolors.kGray,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
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
