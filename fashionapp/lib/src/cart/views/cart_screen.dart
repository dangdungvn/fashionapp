import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/common/widgets/shimmers/list_shimmer.dart';
import 'package:fashionapp/const/resource.dart';
import 'package:fashionapp/src/auth/views/login_screen.dart';
import 'package:fashionapp/src/cart/controllers/cart_notifier.dart';
import 'package:fashionapp/src/cart/hooks/fetch_cart.dart';
import 'package:fashionapp/src/cart/widgets/cart_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class CartPage extends HookWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    final results = fetchCart();
    final carts = results.cart;
    final isLoading = results.isLoading;
    final refetch = results.refetch;

    if (accessToken == null) {
      return const LoginPage();
    }

    if (isLoading) {
      return const Scaffold(body: ListShimmer());
    }

    return Scaffold(
      backgroundColor: Kolors.kOffWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Kolors.kOffWhite,
        centerTitle: true,
        title: const Text(
          AppText.kCart,
          style: TextStyle(
            fontSize: 18,
            color: Kolors.kDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(IconlyLight.delete, color: Kolors.kGray),
            onPressed: carts.isEmpty
                ? null
                : () {
                    // Show confirmation dialog before clearing cart
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Clear Cart'),
                        content: const Text(
                            'Are you sure you want to clear all items?'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Kolors.kGray),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // TODO: Implement clear cart functionality
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Kolors.kRed.withOpacity(0.8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Clear'),
                          ),
                        ],
                      ),
                    );
                  },
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: carts.isEmpty
          // Empty cart view
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    R.ASSETS_IMAGES_EMPTY_PNG,
                    height: 200.h,
                  ),
                  SizedBox(height: 20.h),
                  const Text(
                    "Your cart is empty",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Kolors.kDark,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  const Text(
                    "Looks like you haven't added anything to your cart yet",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Kolors.kGray,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/home');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Kolors.kPrimary,
                      foregroundColor: Kolors.kWhite,
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.w, vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "Start Shopping",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            )
          // Cart items list
          : Stack(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.w),
                  padding: EdgeInsets.only(bottom: 100.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      // Cart items count
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${carts.length} items in your cart",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Kolors.kGray,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 6.h),
                            decoration: BoxDecoration(
                              color: Kolors.kPrimary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Text(
                              "Select All",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Kolors.kPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 15.h),

                      // Cart items
                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: carts.length,
                          itemBuilder: (context, i) {
                            final cart = carts[i];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 15.h),
                              child: CartTile(
                                cart: cart,
                                onDelete: () {
                                  context
                                      .read<CartNotifier>()
                                      .deleteCart(cart.id, refetch);
                                },
                                onUpdate: () {
                                  context
                                      .read<CartNotifier>()
                                      .updateCart(cart.id, refetch);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Checkout button
                Consumer<CartNotifier>(
                  builder: (context, cartNotifier, child) {
                    return Positioned(
                      bottom: 20.h,
                      left: 20.w,
                      right: 20.w,
                      child: cartNotifier.selectedCartItems.isNotEmpty
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 15.h),
                              decoration: BoxDecoration(
                                color: Kolors.kWhite,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: Kolors.kDark.withOpacity(0.08),
                                    blurRadius: 15,
                                    spreadRadius: 1,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Order summary
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Subtotal",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Kolors.kGray,
                                        ),
                                      ),
                                      Text(
                                        "\$${cartNotifier.totalPrice.toStringAsFixed(2)}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Kolors.kDark,
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 15.h),

                                  // Checkout button
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        context.push('/checkout');
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Kolors.kPrimary,
                                        foregroundColor: Kolors.kWhite,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 15.h),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                      ),
                                      child: const Text(
                                        "Proceed to Checkout",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                    );
                  },
                ),
              ],
            ),
    );
  }
}
