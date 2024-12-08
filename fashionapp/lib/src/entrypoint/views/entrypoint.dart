// ignore_for_file: must_be_immutable
import 'package:fashionapp/src/cart/hooks/fetch_cart_count.dart';
import 'package:fashionapp/src/entrypoint/controllers/bottom_tab_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/src/cart/views/cart_screen.dart';
import 'package:fashionapp/src/home/views/home_screen.dart';
import 'package:fashionapp/src/profile/views/profile_screen.dart';
import 'package:fashionapp/src/wishlist/views/wishlist_screen.dart';
import 'package:line_icons/line_icons.dart';
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: GNav(
              haptic: true,
              gap: 8,
              color: Colors.grey.shade500,
              activeColor: Kolors.kDark,
              iconSize: 24,
              tabBackgroundColor: Colors.grey.shade200,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              selectedIndex: tabIndexNotifier.index,
              onTabChange: (i) {
                tabIndexNotifier.setIndex(i);
              },
              tabShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 10,
                ),
              ],
              tabs: [
                const GButton(
                  icon: LineIcons.home,
                  backgroundColor: Color.fromARGB(255, 249, 213, 255),
                  text: "Home",
                ),
                const GButton(
                  icon: LineIcons.heart,
                  backgroundColor: Color.fromARGB(255, 250, 171, 197),
                  text: "Wishlist",
                ),
                GButton(
                  icon: LineIcons.shoppingBag,
                  text: "Cart",
                  backgroundColor: const Color.fromARGB(255, 221, 252, 196),
                  leading: Badge(
                    label: Text(data.cartCount.toString()),
                    child: Icon(
                      LineIcons.shoppingBag,
                      color: tabIndexNotifier.index == 2
                          ? Kolors.kDark
                          : Colors.grey.shade500,
                    ),
                  ),
                ),
                const GButton(
                  icon: LineIcons.userEdit,
                  iconActiveColor: Kolors.kDark,
                  backgroundColor: Color.fromARGB(255, 213, 238, 250),
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
