// ignore_for_file: must_be_immutable
import 'package:fashionapp/src/cart/hooks/fetch_cart_count.dart';
import 'package:fashionapp/src/entrypoint/controllers/bottom_tab_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/src/cart/views/cart_screen.dart';
import 'package:fashionapp/src/home/views/home_screen.dart';
import 'package:fashionapp/src/profile/views/profile_screen.dart';
import 'package:fashionapp/src/wishlist/views/wishlist_screen.dart';
import 'package:provider/provider.dart';
import 'package:google_nav_bar/google_nav_bar.dart'; // Import thư viện

class AppEntryPoint extends HookWidget {
  AppEntryPoint({super.key});
  List<Widget> pageList = [
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
          body: pageList[tabIndexNotifier.index],
          bottomNavigationBar: Container(
            color: Kolors.kOffWhite,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey.shade800,
              hoverColor: Colors.grey.shade700,
              haptic: true,
              tabActiveBorder: Border.all(color: Colors.black, width: 1),
              gap: 8,
              color: Colors.grey[800],
              activeColor: Kolors.kDark,
              iconSize: 24,
              tabBackgroundColor: Colors.grey.shade200,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              selectedIndex: tabIndexNotifier.index,
              onTabChange: (i) {
                tabIndexNotifier.setIndex(i);
              },
              tabs: [
                const GButton(
                  icon: Ionicons.home_outline,
                  text: "Home",
                ),
                const GButton(
                  icon: Ionicons.heart_outline,
                  text: "Wishlist",
                ),
                GButton(
                  icon: MaterialCommunityIcons.cart_outline,
                  text: "Cart",
                  leading: Badge(
                    label: Text(data.cartCount.toString()),
                    child: const Icon(
                      MaterialCommunityIcons.cart_outline,
                    ),
                  ),
                ),
                const GButton(
                  icon: Icons.person_outline,
                  text: "Profile",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
