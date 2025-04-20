import 'package:fashionapp/const/resource.dart';
import 'package:flutter/material.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';

class OnboardingScreenTwo extends StatefulWidget {
  const OnboardingScreenTwo({super.key});

  @override
  State<OnboardingScreenTwo> createState() => _OnboardingScreenTwoState();
}

class _OnboardingScreenTwoState extends State<OnboardingScreenTwo>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.7, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.7, curve: Curves.easeOutCubic),
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
        color: Kolors.kSecondaryLight, // Màu nền đơn giản thay vì gradient
        child: Stack(
          children: [
            // Phần tử trang trí
            Positioned(
              top: screenHeight * 0.1,
              left: -50,
              child: Container(
                width: screenWidth * 0.4,
                height: screenWidth * 0.4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Kolors.kAccent2.withOpacity(0.2),
                ),
              ),
            ),
            Positioned(
              bottom: screenHeight * 0.15,
              right: -40,
              child: Container(
                width: screenWidth * 0.35,
                height: screenWidth * 0.35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Kolors.kAccent.withOpacity(0.15),
                ),
              ),
            ),

            // Nội dung chính
            SafeArea(
              child: Column(
                children: [
                  SizedBox(height: isSmallScreen ? 25 : 35),

                  // Tiêu đề với hiệu ứng
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.08),
                        child: Text(
                          AppText.kOnboardWishList,
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

                  SizedBox(height: isSmallScreen ? 25 : 35),

                  // Hình ảnh thay vì animation Lottie
                  Expanded(
                    flex: 5,
                    child: FadeTransition(
                      opacity: Tween<double>(begin: 0, end: 1).animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve:
                              const Interval(0.3, 0.8, curve: Curves.easeOut),
                        ),
                      ),
                      child: ScaleTransition(
                        scale: Tween<double>(begin: 0.85, end: 1.0).animate(
                          CurvedAnimation(
                            parent: _animationController,
                            curve: const Interval(0.3, 0.8,
                                curve: Curves.easeOutCubic),
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
                                  color: Kolors.kPrimaryLight.withOpacity(0.2),
                                ),

                                // Hình ảnh thay vì animation Lottie
                                Positioned.fill(
                                  child: Image.asset(
                                    R.ASSETS_IMAGES_WISHLIST_PNG,
                                    fit: BoxFit.cover,
                                  ),
                                ),

                                // Lớp overlay tùy chỉnh (tùy chọn)
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: 80,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Kolors.kPrimary.withOpacity(0.1),
                                          Kolors.kPrimary.withOpacity(0.15),
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

                  SizedBox(height: isSmallScreen ? 25 : 35),

                  // Mô tả với hiệu ứng xuất hiện
                  Expanded(
                    flex: 2,
                    child: FadeTransition(
                      opacity: Tween<double>(begin: 0, end: 1).animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve:
                              const Interval(0.4, 0.9, curve: Curves.easeOut),
                        ),
                      ),
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.2),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: _animationController,
                            curve: const Interval(0.4, 0.9,
                                curve: Curves.easeOutCubic),
                          ),
                        ),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.08),
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.06,
                            vertical: screenHeight * 0.025,
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
                                "Danh Sách Yêu Thích Của Bạn",
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 17 : 18,
                                  fontWeight: FontWeight.w600,
                                  color: Kolors.kPrimary,
                                ),
                              ),
                              SizedBox(height: isSmallScreen ? 8 : 10),
                              Expanded(
                                child: Text(
                                  AppText.kOnboardWishListMessage,
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
