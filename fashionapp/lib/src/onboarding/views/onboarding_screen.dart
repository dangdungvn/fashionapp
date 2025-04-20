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
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    _pageController = PageController(
        initialPage: context.read<OnboardingNotifier>().selectedPage);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeOutQuint));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutQuint,
    ));

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
          // Tạo hiệu ứng chuyển trang mượt mà với PageView.builder
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

          // Chỉ hiển thị các điều khiển điều hướng nếu không phải trang cuối
          context.watch<OnboardingNotifier>().selectedPage == 2
              ? const SizedBox.shrink()
              : Positioned(
                  bottom: isSmallScreen ? 25 : 35,
                  left: 0,
                  right: 0,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.06),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Nút quay lại với hiệu ứng nhấn
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
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
                                        duration:
                                            const Duration(milliseconds: 600),
                                        curve: Curves.easeInOutCubic,
                                      );
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(50),
                                  child: Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Kolors.kWhite,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Kolors.kDark.withOpacity(0.08),
                                          blurRadius: 15,
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
                              ),
                            ),

                            // Chỉ báo trang với hiệu ứng
                            Expanded(
                              child: Center(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Kolors.kWhite,
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Kolors.kDark.withOpacity(0.05),
                                        blurRadius: 15,
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
                                    size: Size(8, 8),
                                    unselectedSize: Size(6, 6),
                                    duration: const Duration(milliseconds: 300),
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    onItemClicked: (index) {
                                      _pageController.animateToPage(
                                        index,
                                        duration:
                                            const Duration(milliseconds: 600),
                                        curve: Curves.easeInOutCubic,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),

                            // Nút tiếp theo với hiệu ứng nhấn và chuyển động
                            TweenAnimationBuilder<double>(
                              tween: Tween<double>(begin: 0.95, end: 1.0),
                              duration: const Duration(milliseconds: 1500),
                              curve: Curves.elasticOut,
                              builder: (context, value, child) {
                                return Transform.scale(
                                  scale: value,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
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
                                            duration: const Duration(
                                                milliseconds: 600),
                                            curve: Curves.easeInOutCubic,
                                          );
                                        }
                                      },
                                      borderRadius: BorderRadius.circular(50),
                                      child: Container(
                                        width: 48,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Kolors.kPrimary,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Kolors.kPrimary
                                                  .withOpacity(0.3),
                                              blurRadius: 12,
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
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
