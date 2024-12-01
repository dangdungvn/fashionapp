// ignore_for_file: must_be_immutable

import 'package:fashionapp/common/widgets/app_style.dart';
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
          body: Stack(
            children: [
              pageList[tabIndexNotifier.index],
              Align(
                alignment: Alignment.bottomCenter,
                child: Theme(
                  data:
                      Theme.of(context).copyWith(canvasColor: Kolors.kOffWhite),
                  child: BottomNavigationBar(
                    selectedFontSize: 12,
                    elevation: 0,
                    enableFeedback: true,
                    // landscapeLayout:
                    //     BottomNavigationBarLandscapeLayout.centered,
                    backgroundColor: Kolors.kOffWhite,
                    showSelectedLabels: true,
                    selectedLabelStyle:
                        appStyle(9, Kolors.kPrimary, FontWeight.w500),
                    showUnselectedLabels: false,
                    currentIndex: tabIndexNotifier.index,
                    selectedItemColor: Kolors.kPrimary,
                    unselectedItemColor: Kolors.kGray,
                    unselectedIconTheme:
                        const IconThemeData(color: Colors.black38),
                    onTap: (i) {
                      tabIndexNotifier.setIndex(i);
                    },
                    items: [
                      BottomNavigationBarItem(
                        icon: tabIndexNotifier.index == 0
                            ? const Icon(
                                Ionicons.home,
                                color: Kolors.kPrimary,
                                size: 24,
                              )
                            : const Icon(
                                Ionicons.home_outline,
                                size: 24,
                              ),
                        label: "Home",
                      ),
                      BottomNavigationBarItem(
                        icon: tabIndexNotifier.index == 1
                            ? const Icon(
                                Ionicons.ios_heart,
                                color: Kolors.kPrimary,
                                size: 24,
                              )
                            : const Icon(
                                Ionicons.heart_outline,
                              ),
                        label: "WistList",
                      ),
                      BottomNavigationBarItem(
                        icon: tabIndexNotifier.index == 2
                            ? Badge(
                                label: Text(data.cartCount.toString()),
                                child: const Icon(
                                  MaterialCommunityIcons.cart,
                                  color: Kolors.kPrimary,
                                  size: 24,
                                ),
                              )
                            : Badge(
                                label: Text(data.cartCount.toString()),
                                child: const Icon(
                                  MaterialCommunityIcons.cart_outline,
                                ),
                              ),
                        label: "Cart",
                      ),
                      BottomNavigationBarItem(
                        icon: tabIndexNotifier.index == 3
                            ? const Icon(
                                Icons.person_rounded,
                                color: Kolors.kPrimary,
                                size: 34,
                              )
                            : const Icon(
                                Icons.person_outline,
                                size: 34,
                              ),
                        label: "Profile",
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
