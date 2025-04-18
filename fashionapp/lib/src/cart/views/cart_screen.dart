// ignore_for_file: deprecated_member_use

import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
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
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          AppText.kCart,
          style: GoogleFonts.poppins(
            fontSize: 18,
            color: Kolors.kDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: carts.isEmpty
                    ? Kolors.kGray.withOpacity(0.1)
                    : Kolors.kRed.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                IconlyLight.delete,
                color: carts.isEmpty ? Kolors.kGray : Kolors.kRed,
                size: 20,
              ),
            ),
            onPressed: carts.isEmpty
                ? null
                : () {
                    // Show confirmation dialog before clearing cart
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(
                          'Xóa giỏ hàng',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Kolors.kDark,
                          ),
                        ),
                        content: Text(
                          'Bạn có chắc chắn muốn xóa tất cả sản phẩm?',
                          style: GoogleFonts.poppins(
                            color: Kolors.kGray,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'Hủy',
                              style: GoogleFonts.poppins(
                                color: Kolors.kGray,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // TODO: Implement clear cart functionality
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Kolors.kRed.withOpacity(0.8),
                              foregroundColor: Kolors.kWhite,
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 8.h,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Xóa tất cả',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Kolors.kOffWhite,
              Kolors.kWhite,
              Kolors.kSecondaryLight.withOpacity(0.3),
            ],
          ),
        ),
        child: carts.isEmpty
            // Empty cart view with animation
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      R.ASSETS_ANIMATIONS_LOADING_JSON,
                      height: 180.h,
                      repeat: true,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Giỏ hàng trống",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Kolors.kDark,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.w),
                      child: Text(
                        "Bạn chưa thêm sản phẩm nào vào giỏ hàng",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Kolors.kGray,
                        ),
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
                        elevation: 2,
                        shadowColor: Kolors.kPrimary.withOpacity(0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(IconlyBold.bag),
                          SizedBox(width: 8.w),
                          Text(
                            "Mua sắm ngay",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            // Cart items list with enhanced UI
            : Stack(
                children: [
                  // Decorative elements
                  Positioned(
                    top: -50,
                    right: -30,
                    child: Container(
                      width: 150.w,
                      height: 150.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Kolors.kPrimary.withOpacity(0.05),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 100,
                    left: -50,
                    child: Container(
                      width: 180.w,
                      height: 180.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Kolors.kPrimaryLight.withOpacity(0.05),
                      ),
                    ),
                  ),

                  // Main content
                  SafeArea(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      padding: EdgeInsets.only(bottom: 87.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15.h),

                          // Cart header with items count and select all
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 5.w),
                            decoration: BoxDecoration(
                              color: Kolors.kWhite,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Kolors.kDark.withOpacity(0.03),
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8.w),
                                      decoration: BoxDecoration(
                                        color: Kolors.kPrimaryLight
                                            .withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        IconlyBold.bag_2,
                                        size: 18.sp,
                                        color: Kolors.kPrimary,
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${carts.length} sản phẩm",
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Kolors.kDark,
                                          ),
                                        ),
                                        Text(
                                          "Trong giỏ hàng của bạn",
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: Kolors.kGray,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                // Select all button
                                GestureDetector(
                                  onTap: () {
                                    final cartNotifier =
                                        context.read<CartNotifier>();
                                    for (var cart in carts) {
                                      if (!cartNotifier.selectedCartItemsId
                                          .contains(cart.id)) {
                                        cartNotifier.selectOrDeselect(
                                            cart.id, cart);
                                      }
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 8.h),
                                    decoration: BoxDecoration(
                                      color: Kolors.kPrimary.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(16.r),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          IconlyLight.tick_square,
                                          size: 16.sp,
                                          color: Kolors.kPrimary,
                                        ),
                                        SizedBox(width: 5.w),
                                        Text(
                                          "Chọn tất cả",
                                          style: GoogleFonts.poppins(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Kolors.kPrimary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 20.h),

                          // Cart items list
                          Expanded(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: carts.length,
                              itemBuilder: (context, i) {
                                final cart = carts[i];
                                return Padding(
                                  padding:
                                      EdgeInsets.only(bottom: 15.h, left: 10.w),
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
                          Consumer<CartNotifier>(
                            builder: (context, cartNotifier, child) {
                              return SizedBox(
                                height:
                                    cartNotifier.selectedCartItemsId.isNotEmpty
                                        ? 140.h
                                        : 0,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Checkout button
                  Consumer<CartNotifier>(
                    builder: (context, cartNotifier, child) {
                      final hasSelectedItems =
                          cartNotifier.selectedCartItems.isNotEmpty;
                      return AnimatedPositioned(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        bottom: hasSelectedItems ? 100.h : -100.h,
                        left: 20.w,
                        right: 20.w,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: hasSelectedItems ? 1.0 : 0.0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 20.h),
                            decoration: BoxDecoration(
                              color: Kolors.kWhite,
                              borderRadius: BorderRadius.circular(25.r),
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
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Tổng tiền",
                                          style: GoogleFonts.poppins(
                                            fontSize: 14.sp,
                                            color: Kolors.kGray,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          "\$${cartNotifier.totalPrice.toStringAsFixed(2)}",
                                          style: GoogleFonts.poppins(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Kolors.kPrimary,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                        vertical: 6.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Kolors.kPrimaryLight
                                            .withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        "${cartNotifier.selectedCartItems.length} sản phẩm",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Kolors.kPrimary,
                                        ),
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
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16.h),
                                      elevation: 2,
                                      shadowColor:
                                          Kolors.kPrimary.withOpacity(0.3),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.r),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          IconlyBold.wallet,
                                          size: 20.sp,
                                        ),
                                        SizedBox(width: 8.w),
                                        Text(
                                          "Thanh toán ngay",
                                          style: GoogleFonts.poppins(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
