import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/const/resource.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bool isSmallScreen = screenHeight < 700;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Kolors.kSecondaryLight,
              Kolors.kOffWhite,
              Kolors.kAccent2.withOpacity(0.3),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Decorative elements
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: screenWidth * 0.7,
                height: screenWidth * 0.7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Kolors.kPrimary.withOpacity(0.15),
                ),
              ),
            ),
            Positioned(
              bottom: -70,
              left: -70,
              child: Container(
                width: screenWidth * 0.45,
                height: screenWidth * 0.45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Kolors.kAccent.withOpacity(0.2),
                ),
              ),
            ),

            // Main content
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(height: isSmallScreen ? 40 : 60),
                    // Image with enhanced presentation
                    Container(
                      width: screenWidth * 0.85,
                      height: screenHeight * (isSmallScreen ? 0.35 : 0.40),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Kolors.kDark.withOpacity(0.05),
                            blurRadius: 20,
                            spreadRadius: 1,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          R.ASSETS_IMAGES_GETSTARTED_PNG,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.04),

                    // Welcome content
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.03,
                        horizontal: screenWidth * 0.05,
                      ),
                      margin:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                      decoration: BoxDecoration(
                        color: Kolors.kWhite.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(25),
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
                            AppText.kWelcomeHeader,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isSmallScreen ? 22 : 24,
                              fontWeight: FontWeight.bold,
                              color: Kolors.kPrimary,
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: isSmallScreen ? 12 : 15),
                          Text(
                            AppText.kWelcomeMessage,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isSmallScreen ? 15 : 16,
                              fontWeight: FontWeight.normal,
                              color: Kolors.kGray,
                              height: 1.5,
                            ),
                          ),
                          SizedBox(height: isSmallScreen ? 20 : 30),

                          // Get started button with enhanced style
                          ElevatedButton(
                            onPressed: () {
                              context.go('/home');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Kolors.kPrimary,
                              foregroundColor: Kolors.kWhite,
                              padding: EdgeInsets.symmetric(
                                vertical: isSmallScreen ? 12 : 15,
                                horizontal: 30,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 3,
                              shadowColor: Kolors.kPrimary.withOpacity(0.5),
                            ),
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Text(
                                AppText.kGetStarted,
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 15 : 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: isSmallScreen ? 15 : 20),

                    // Sign in option
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account",
                          style: TextStyle(
                            fontSize: isSmallScreen ? 14 : 15,
                            color: Kolors.kDark.withOpacity(0.8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.go('/login');
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Kolors.kPrimary,
                            textStyle: TextStyle(
                              fontSize: isSmallScreen ? 14 : 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          child: const Text("Sign In"),
                        ),
                      ],
                    ),
                    SizedBox(height: isSmallScreen ? 15 : 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
