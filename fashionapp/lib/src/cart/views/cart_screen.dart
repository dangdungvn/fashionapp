import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/common/widgets/shimmers/list_shimmer.dart';
import 'package:fashionapp/src/auth/views/login_screen.dart';
import 'package:fashionapp/src/cart/controllers/cart_notifier.dart';
import 'package:fashionapp/src/cart/hooks/fetch_cart.dart';
import 'package:fashionapp/src/cart/widgets/cart_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CartPage extends HookWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    final results = fetchCart();
    final carts = results.cart;
    final isLoading = results.isLoading;
    // final error = results.error;
    final refetch = results.refetch;
    if (accessToken == null) {
      return const LoginPage();
    }
    if (isLoading) {
      return const Scaffold(body: ListShimmer());
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ReusableText(
          text: AppText.kCart,
          style: appStyle(15, Kolors.kPrimary, FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            children: List.generate(
              carts.length,
              (i) {
                final cart = carts[i];
                return CartTile(
                  cart: cart,
                  onDelete: () {
                    context.read<CartNotifier>().deleteCart(cart.id, refetch);
                  },
                  onUpdate: () {
                    context.read<CartNotifier>().updateCart(cart.id, refetch);
                  },
                );
              },
            ),
          ),
          Consumer<CartNotifier>(
            builder: (context, cartNotifier, child) {
              return Positioned(
                bottom: 100.h,
                left: 50.w,
                right: 50.w,
                child: GestureDetector(
                  onTap: () {
                    context.push('/checkout');
                  },
                  child: cartNotifier.selectedCartItems.isNotEmpty
                      ? Container(
                          height: 60.h,
                          decoration: BoxDecoration(
                            color: Kolors.kPrimaryLight,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          // width: ScreenUtil().screenWidth / 5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                child: ReusableText(
                                  text: "Click to Checkout",
                                  style: appStyle(
                                      15, Kolors.kWhite, FontWeight.w600),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                child: ReusableText(
                                  text:
                                      "\$ ${cartNotifier.totalPrice.toStringAsFixed(2)}",
                                  style: appStyle(
                                      15, Kolors.kWhite, FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
