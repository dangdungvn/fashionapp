import 'package:fashionapp/const/resource.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.1, 0.6, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.1, 0.6, curve: Curves.easeOutCubic),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.7, curve: Curves.easeOutQuart),
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
        decoration: BoxDecoration(
          color: Kolors.kOffWhite, // Nền đơn sắc thay vì gradient
        ),
        child: Stack(
          children: [
            // Phần tử trang trí
            Positioned(
              top: -80,
              right: -80,
              child: Container(
                width: screenWidth * 0.7,
                height: screenWidth * 0.7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Kolors.kPrimaryLight.withOpacity(0.15),
                ),
              ),
            ),
            Positioned(
              bottom: -70,
              left: -70,
              child: Container(
                width: screenWidth * 0.5,
                height: screenWidth * 0.5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Kolors.kAccent.withOpacity(0.15),
                ),
              ),
            ),

            // Nội dung chính
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(height: isSmallScreen ? 30 : 40),

                    // Tiêu đề với hiệu ứng
                    SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.08),
                          child: Text(
                            "Chào Mừng Đến Với\nFashion App",
                            style: TextStyle(
                              fontSize: isSmallScreen ? 26 : 28,
                              fontWeight: FontWeight.bold,
                              color: Kolors.kDark,
                              height: 1.3,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: isSmallScreen ? 5 : 10),

                    // Mô tả ngắn với hiệu ứng
                    SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.3),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: const Interval(0.2, 0.7,
                              curve: Curves.easeOutQuart),
                        ),
                      ),
                      child: FadeTransition(
                        opacity: Tween<double>(begin: 0, end: 1).animate(
                          CurvedAnimation(
                            parent: _animationController,
                            curve:
                                const Interval(0.2, 0.7, curve: Curves.easeOut),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.12),
                          child: Text(
                            AppText.kWelcomeMessage,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isSmallScreen ? 14 : 15,
                              color: Kolors.kGray,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: isSmallScreen ? 25 : 35),

                    // Animation Lottie thời trang
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Container(
                          width: screenWidth * 0.85,
                          height: screenHeight * (isSmallScreen ? 0.33 : 0.38),
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
                                      Kolors.kSecondaryLight.withOpacity(0.5),
                                ),

                                // Animation Lottie
                                Positioned.fill(
                                  child: Image.asset(
                                    R.ASSETS_IMAGES_GETSTARTED_PNG,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: isSmallScreen ? 30 : 40),

                    // Container chứa nút bắt đầu và đăng nhập
                    SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.4),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: const Interval(0.3, 0.8,
                              curve: Curves.easeOutQuart),
                        ),
                      ),
                      child: FadeTransition(
                        opacity: Tween<double>(begin: 0, end: 1).animate(
                          CurvedAnimation(
                            parent: _animationController,
                            curve:
                                const Interval(0.3, 0.8, curve: Curves.easeOut),
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.03,
                            horizontal: screenWidth * 0.06,
                          ),
                          margin: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.08),
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
                            children: [
                              // Nút bắt đầu với hiệu ứng gợn sóng khi nhấn
                              TweenAnimationBuilder<double>(
                                tween: Tween<double>(begin: 0.95, end: 1.0),
                                duration: const Duration(milliseconds: 1000),
                                curve: Curves.elasticOut,
                                builder: (context, value, child) {
                                  return Transform.scale(
                                    scale: value,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        context.go('/home');
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Kolors.kPrimary,
                                        foregroundColor: Kolors.kWhite,
                                        padding: EdgeInsets.symmetric(
                                          vertical: isSmallScreen ? 13 : 16,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                        ),
                                        elevation: 4,
                                        shadowColor:
                                            Kolors.kPrimary.withOpacity(0.4),
                                      ),
                                      child: Container(
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              AppText.kGetStarted,
                                              style: TextStyle(
                                                fontSize:
                                                    isSmallScreen ? 15 : 16,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            const Icon(
                                              Icons.arrow_forward_rounded,
                                              size: 18,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),

                              SizedBox(height: isSmallScreen ? 15 : 20),

                              // Tùy chọn đăng nhập với hiệu ứng
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Đã có tài khoản?",
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
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 5,
                                      ),
                                    ),
                                    child: const Text("Đăng Nhập"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: isSmallScreen ? 25 : 30),
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
