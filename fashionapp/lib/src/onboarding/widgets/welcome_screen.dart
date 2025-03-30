import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/custom_button.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/const/constants.dart';
import 'package:fashionapp/const/resource.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
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
                width: 300,
                height: 300,
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
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Kolors.kAccent.withOpacity(0.2),
                ),
              ),
            ),

            // Main content
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 80.h),
                  // Image with enhanced presentation
                  Container(
                    width: ScreenUtil().screenWidth * 0.85,
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

                  SizedBox(height: 40.h),

                  // Welcome content
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25, horizontal: 20),
                    margin: const EdgeInsets.symmetric(horizontal: 25),
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
                        const Text(
                          AppText.kWelcomeHeader,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Kolors.kPrimary,
                            height: 1.2,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        const Text(
                          AppText.kWelcomeMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Kolors.kGray,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 30.h),

                        // Get started button with enhanced style
                        ElevatedButton(
                          onPressed: () {
                            context.go('/home');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Kolors.kPrimary,
                            foregroundColor: Kolors.kWhite,
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 30),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 3,
                            shadowColor: Kolors.kPrimary.withOpacity(0.5),
                          ),
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: const Text(
                              AppText.kGetStarted,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Sign in option
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account",
                        style: TextStyle(
                          fontSize: 15,
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
                          textStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        child: const Text("Sign In"),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
