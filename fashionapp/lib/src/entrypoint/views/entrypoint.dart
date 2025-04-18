// ignore_for_file: must_be_immutable
import 'package:fashionapp/src/cart/hooks/fetch_cart_count.dart';
import 'package:fashionapp/src/entrypoint/controllers/bottom_tab_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/src/cart/views/cart_screen.dart';
import 'package:fashionapp/src/home/views/home_screen.dart';
import 'package:fashionapp/src/profile/views/profile_screen.dart';
import 'package:fashionapp/src/wishlist/views/wishlist_screen.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class AppEntryPoint extends HookWidget {
  AppEntryPoint({super.key});

  final List<Widget> pageList = [
    const HomePage(),
    const WishlistPage(),
    const CartPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final rslt = fetchCartCount(context);
    final data = rslt.count;

    return Consumer<TabIndexNotifier>(
      builder: (context, tabIndexNotifier, child) {
        return Scaffold(
          body: Stack(
            children: [
              // Main content pages
              pageList[tabIndexNotifier.index],

              // Bottom navigation bar with modern pastel design
              Positioned(
                bottom: 15,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: Kolors.kWhite,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Kolors.kDark.withOpacity(0.08),
                          blurRadius: 15,
                          spreadRadius: 1,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildNavItem(
                          icon: IconlyBold.home,
                          iconOutlined: IconlyLight.home,
                          label: "Home",
                          index: 0,
                          currentIndex: tabIndexNotifier.index,
                          onTap: () => tabIndexNotifier.setIndex(0),
                          color: Kolors.kPrimary,
                        ),
                        _buildNavItem(
                          icon: IconlyBold.heart,
                          iconOutlined: IconlyLight.heart,
                          label: "Wishlist",
                          index: 1,
                          currentIndex: tabIndexNotifier.index,
                          onTap: () => tabIndexNotifier.setIndex(1),
                          color: Kolors.kAccent,
                        ),
                        _buildNavItem(
                          icon: IconlyBold.bag,
                          iconOutlined: IconlyLight.bag,
                          label: "Cart",
                          index: 2,
                          currentIndex: tabIndexNotifier.index,
                          onTap: () => tabIndexNotifier.setIndex(2),
                          color: Kolors.kGreen,
                          badge: data.cartCount > 0
                              ? data.cartCount.toString()
                              : null,
                        ),
                        _buildNavItem(
                          icon: IconlyBold.profile,
                          iconOutlined: IconlyLight.profile,
                          label: "Profile",
                          index: 3,
                          currentIndex: tabIndexNotifier.index,
                          onTap: () => tabIndexNotifier.setIndex(3),
                          color: Kolors.kBlue,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Helper method to build individual navigation item
  Widget _buildNavItem({
    required IconData icon,
    required IconData iconOutlined,
    required String label,
    required int index,
    required int currentIndex,
    required VoidCallback onTap,
    required Color color,
    String? badge,
  }) {
    final bool isSelected = index == currentIndex;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon with badge if needed
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  isSelected ? icon : iconOutlined,
                  color: isSelected ? color : Kolors.kGray,
                  size: 24,
                ),
                if (badge != null)
                  Positioned(
                    top: -5,
                    right: -5,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Kolors.kRed,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Center(
                        child: Text(
                          badge,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            SizedBox(height: 4.h),

            // Label text
            isSelected
                ? Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
