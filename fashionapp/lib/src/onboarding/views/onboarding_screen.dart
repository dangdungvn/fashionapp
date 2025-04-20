import 'package:flutter/material.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/src/onboarding/controllers/onboarding_notifier.dart';
import 'package:fashionapp/src/onboarding/widgets/onboarding_page_one.dart';
import 'package:fashionapp/src/onboarding/widgets/onboarding_page_two.dart';
import 'package:fashionapp/src/onboarding/widgets/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    _pageController = PageController(
        initialPage: context.read<OnboardingNotifier>().selectedPage);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn));

    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenHeight < 700;

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (page) {
              context.read<OnboardingNotifier>().setSelectedPage = page;
              _animationController.reset();
              _animationController.forward();
            },
            children: const [
              OnboardingScreenOne(),
              OnboardingScreenTwo(),
              WelcomeScreen(),
            ],
          ),
          context.watch<OnboardingNotifier>().selectedPage == 2
              ? const SizedBox.shrink()
              : Positioned(
                  bottom: isSmallScreen ? 20 : 30,
                  left: 0,
                  right: 0,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Nút quay lại
                          GestureDetector(
                            onTap: () {
                              if (context
                                      .read<OnboardingNotifier>()
                                      .selectedPage >
                                  0) {
                                _pageController.animateToPage(
                                  context
                                          .read<OnboardingNotifier>()
                                          .selectedPage -
                                      1,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Kolors.kWhite,
                                boxShadow: [
                                  BoxShadow(
                                    color: Kolors.kDark.withOpacity(0.1),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.arrow_back_rounded,
                                color: context
                                            .read<OnboardingNotifier>()
                                            .selectedPage >
                                        0
                                    ? Kolors.kPrimary
                                    : Kolors.kGrayLight,
                                size: 20,
                              ),
                            ),
                          ),

                          // Chỉ báo trang - được bọc trong Flexible để có thể co giãn
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: isSmallScreen ? 8 : 10,
                                  vertical: 6),
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Kolors.kWhite,
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    color: Kolors.kDark.withOpacity(0.05),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: PageViewDotIndicator(
                                currentItem: context
                                    .watch<OnboardingNotifier>()
                                    .selectedPage,
                                count: 3,
                                unselectedColor: Kolors.kGrayLight,
                                selectedColor: Kolors.kPrimary,
                                size: Size(isSmallScreen ? 7 : 8,
                                    isSmallScreen ? 7 : 8),
                                unselectedSize: Size(isSmallScreen ? 5 : 6,
                                    isSmallScreen ? 5 : 6),
                                duration: const Duration(milliseconds: 300),
                                margin: EdgeInsets.symmetric(
                                    horizontal: isSmallScreen ? 3 : 5),
                                onItemClicked: (index) {
                                  _pageController.animateToPage(
                                    index,
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeInOut,
                                  );
                                },
                              ),
                            ),
                          ),

                          // Nút tiếp theo
                          GestureDetector(
                            onTap: () {
                              if (context
                                      .read<OnboardingNotifier>()
                                      .selectedPage <
                                  2) {
                                _pageController.animateToPage(
                                  context
                                          .read<OnboardingNotifier>()
                                          .selectedPage +
                                      1,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  colors: [Kolors.kPrimary, Kolors.kAccent],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Kolors.kPrimary.withOpacity(0.3),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.arrow_forward_rounded,
                                color: Kolors.kWhite,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
