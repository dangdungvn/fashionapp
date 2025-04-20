import 'package:fashionapp/const/resource.dart';
import 'package:flutter/material.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';

class OnboardingScreenOne extends StatefulWidget {
  const OnboardingScreenOne({super.key});

  @override
  State<OnboardingScreenOne> createState() => _OnboardingScreenOneState();
}

class _OnboardingScreenOneState extends State<OnboardingScreenOne>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOutQuart),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bool isSmallScreen = screenHeight < 700;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        color: Kolors.kOffWhite, // Màu nền đơn giản thay vì gradient
        child: Stack(
          children: [
            // Phần tử trang trí
            Positioned(
              top: -50,
              right: -30,
              child: Container(
                width: screenWidth * 0.5,
                height: screenWidth * 0.5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Kolors.kAccent.withOpacity(0.15),
                ),
              ),
            ),
            Positioned(
              bottom: -80,
              left: -50,
              child: Container(
                width: screenWidth * 0.6,
                height: screenWidth * 0.6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Kolors.kPrimaryLight.withOpacity(0.2),
                ),
              ),
            ),

            // Nội dung chính
            SafeArea(
              child: Column(
                children: [
                  SizedBox(height: isSmallScreen ? 20 : 30),
                  // Tiêu đề với hiệu ứng
                  SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.08),
                        child: Text(
                          "Khám Phá Phong Cách Thời Trang",
                          style: TextStyle(
                            fontSize: isSmallScreen ? 24 : 26,
                            fontWeight: FontWeight.bold,
                            color: Kolors.kDark,
                            height: 1.3,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: isSmallScreen ? 15 : 25),

                  // Hình ảnh thay vì animation
                  Expanded(
                    flex: 5,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.1),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: const Interval(0.3, 0.9,
                              curve: Curves.easeOutQuart),
                        ),
                      ),
                      child: FadeTransition(
                        opacity: Tween<double>(begin: 0, end: 1).animate(
                          CurvedAnimation(
                            parent: _animationController,
                            curve:
                                const Interval(0.3, 0.9, curve: Curves.easeOut),
                          ),
                        ),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.08),
                          decoration: BoxDecoration(
                            color: Kolors.kWhite,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Kolors.kDark.withOpacity(0.08),
                                blurRadius: 20,
                                spreadRadius: 1,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Stack(
                              children: [
                                // Background Color
                                Container(
                                  color:
                                      Kolors.kSecondaryLight.withOpacity(0.3),
                                ),

                                // Hình ảnh thay vì animation Lottie
                                Positioned.fill(
                                  child: Image.asset(
                                    R.ASSETS_IMAGES_EXPERIENCE_PNG,
                                    fit: BoxFit.cover,
                                  ),
                                ),

                                // Hiệu ứng gradient ở dưới (tùy chọn)
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Kolors.kSecondaryLight
                                              .withOpacity(0.2),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: isSmallScreen ? 20 : 30),

                  // Mô tả trong một container có kiểu dáng
                  Expanded(
                    flex: 2,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.3),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: const Interval(0.4, 1.0,
                              curve: Curves.easeOutQuart),
                        ),
                      ),
                      child: FadeTransition(
                        opacity: Tween<double>(begin: 0, end: 1).animate(
                          CurvedAnimation(
                            parent: _animationController,
                            curve:
                                const Interval(0.4, 1.0, curve: Curves.easeOut),
                          ),
                        ),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.08),
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.06,
                            vertical: isSmallScreen ? 20 : 25,
                          ),
                          decoration: BoxDecoration(
                            color: Kolors.kWhite,
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
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Xu Hướng Mới Nhất",
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 17 : 18,
                                  fontWeight: FontWeight.w600,
                                  color: Kolors.kPrimary,
                                ),
                              ),
                              SizedBox(height: isSmallScreen ? 8 : 10),
                              Expanded(
                                child: Text(
                                  AppText.kOnboardHome,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 14 : 15,
                                    height: 1.5,
                                    color: Kolors.kGray,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  maxLines: isSmallScreen ? 4 : 5,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 70 : 85),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
