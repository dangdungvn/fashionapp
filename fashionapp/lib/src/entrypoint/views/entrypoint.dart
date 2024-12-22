// ignore_for_file: must_be_immutable
import 'package:fashionapp/const/resource.dart';
import 'package:fashionapp/src/cart/hooks/fetch_cart_count.dart';
import 'package:fashionapp/src/entrypoint/controllers/bottom_tab_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/src/cart/views/cart_screen.dart';
import 'package:fashionapp/src/home/views/home_screen.dart';
import 'package:fashionapp/src/profile/views/profile_screen.dart';
import 'package:fashionapp/src/wishlist/views/wishlist_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                GButton(
                  icon: Icons.home,
                  leading: SizedBox(
                    width: 20,
                    height: 20,
                    child: SvgPicture.asset(
                      R.ASSETS_HOME_SVG_ICON,
                      colorFilter: ColorFilter.mode(
                        tabIndexNotifier.index == 0
                            ? Kolors.kDark
                            : Colors.grey.shade500,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  backgroundColor: const Color.fromARGB(255, 249, 213, 255),
                  text: "Home",
                ),
                GButton(
                  icon: LineIcons.heart,
                  leading: SizedBox(
                    width: 20,
                    height: 20,
                    child: SvgPicture.asset(
                      R.ASSETS_HEART_SVG_ICON,
                      colorFilter: ColorFilter.mode(
                        tabIndexNotifier.index == 1
                            ? Kolors.kDark
                            : Colors.grey.shade500,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  backgroundColor: const Color.fromARGB(255, 250, 171, 197),
                  text: "Wishlist",
                ),
                GButton(
                  icon: LineIcons.shoppingBag,
                  text: "Cart",
                  backgroundColor: const Color.fromARGB(255, 221, 252, 196),
                  leading: Badge(
                    label: data.cartCount == 0
                        ? null
                        : Text(data.cartCount.toString()),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: SvgPicture.asset(
                        R.ASSETS_CART_SVG_ICON,
                        colorFilter: ColorFilter.mode(
                          tabIndexNotifier.index == 2
                              ? Kolors.kDark
                              : Colors.grey.shade500,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
                GButton(
                  icon: LineIcons.userEdit,
                  leading: SizedBox(
                    width: 20,
                    height: 20,
                    child: SvgPicture.asset(
                      R.ASSETS_USER_SVG_ICON,
                      colorFilter: ColorFilter.mode(
                        tabIndexNotifier.index == 3
                            ? Kolors.kDark
                            : Colors.grey.shade500,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  backgroundColor: const Color.fromARGB(255, 213, 238, 250),
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
