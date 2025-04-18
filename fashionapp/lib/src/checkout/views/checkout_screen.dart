import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/common/widgets/back_button.dart';
import 'package:fashionapp/const/resource.dart';
import 'package:fashionapp/src/addresses/controllers/address_notifier.dart';
import 'package:fashionapp/src/addresses/hooks/fetch_defaults.dart';
import 'package:fashionapp/src/addresses/widgets/address_block.dart';
import 'package:fashionapp/src/cart/controllers/cart_notifier.dart';
import 'package:fashionapp/src/checkout/models/check_out_model.dart';
import 'package:fashionapp/src/checkout/views/payment.dart';
import 'package:fashionapp/src/checkout/widgets/checkout_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends HookWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    final rzlt = fetchDefaultAddress();
    final address = rzlt.address;
    final isLoading = rzlt.isLoading;

    return context
            .watch<CartNotifier>()
            .paymentUrl
            .contains('https://checkout.stripe.com')
        ? const PaymentWebView()
        : Scaffold(
            backgroundColor: Kolors.kOffWhite,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              scrolledUnderElevation: 0,
              surfaceTintColor: Colors.transparent,
              leading: AppBackButton(
                onTap: () {
                  // clear the address
                  context.read<AddressNotifier>().clearAddress();
                  context.pop();
                },
              ),
              centerTitle: true,
              title: Text(
                AppText.kCheckout,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Kolors.kPrimary,
                ),
              ),
            ),
            body: Consumer<CartNotifier>(
              builder: (context, cartNotifier, child) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Kolors.kOffWhite,
                        Kolors.kWhite,
                        Kolors.kSecondaryLight.withOpacity(0.2),
                      ],
                    ),
                  ),
                  child: Stack(
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
                            color: Kolors.kPrimary.withOpacity(0.03),
                          ),
                        ),
                      ),

                      // Main content
                      SafeArea(
                        child: ListView(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          children: [
                            SizedBox(height: 15.h),

                            // Header with animation
                            Row(
                              children: [
                                Lottie.asset(
                                  R.ASSETS_ANIMATIONS_LOADING_JSON,
                                  width: 40.w,
                                  height: 40.w,
                                  repeat: true,
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Thanh toán đơn hàng",
                                        style: GoogleFonts.poppins(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Kolors.kDark,
                                        ),
                                      ),
                                      Text(
                                        "Vui lòng kiểm tra thông tin đơn hàng trước khi thanh toán",
                                        style: GoogleFonts.poppins(
                                          fontSize: 12.sp,
                                          color: Kolors.kGray,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 20.h),

                            // Order summary card
                            Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: Kolors.kWhite,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Kolors.kDark.withOpacity(0.03),
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Thông tin đơn hàng",
                                        style: GoogleFonts.poppins(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Kolors.kDark,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                          vertical: 4.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Kolors.kPrimaryLight
                                              .withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              IconlyBold.bag_2,
                                              size: 14.sp,
                                              color: Kolors.kPrimary,
                                            ),
                                            SizedBox(width: 4.w),
                                            Text(
                                              "${cartNotifier.selectedCartItems.length} món",
                                              style: GoogleFonts.poppins(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Kolors.kPrimary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  Divider(
                                    color: Kolors.kGray.withOpacity(0.2),
                                    height: 25.h,
                                  ),

                                  // Subtotal and total
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Tạm tính:",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14.sp,
                                          color: Kolors.kGray,
                                        ),
                                      ),
                                      Text(
                                        "\$${cartNotifier.totalPrice.toStringAsFixed(2)}",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Kolors.kDark,
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 8.h),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Phí vận chuyển:",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14.sp,
                                          color: Kolors.kGray,
                                        ),
                                      ),
                                      Text(
                                        "Miễn phí",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Kolors.kPrimary,
                                        ),
                                      ),
                                    ],
                                  ),

                                  Divider(
                                    color: Kolors.kGray.withOpacity(0.2),
                                    height: 25.h,
                                  ),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Tổng cộng:",
                                        style: GoogleFonts.poppins(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Kolors.kDark,
                                        ),
                                      ),
                                      Text(
                                        "\$${cartNotifier.totalPrice.toStringAsFixed(2)}",
                                        style: GoogleFonts.poppins(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Kolors.kPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 20.h),

                            // Address block with new title
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      IconlyBold.location,
                                      size: 20.sp,
                                      color: Kolors.kPrimary,
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      "Địa chỉ giao hàng",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Kolors.kDark,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                isLoading
                                    ? Center(
                                        child: Lottie.asset(
                                          R.ASSETS_ANIMATIONS_LOADING_JSON,
                                          width: 80.w,
                                          height: 80.w,
                                        ),
                                      )
                                    : AddressBlock(
                                        address: address,
                                      ),
                              ],
                            ),

                            SizedBox(height: 20.h),

                            // Products list title
                            Row(
                              children: [
                                Icon(
                                  IconlyBold.bag,
                                  size: 20.sp,
                                  color: Kolors.kPrimary,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  "Sản phẩm đã chọn",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Kolors.kDark,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 10.h),

                            // Product list
                            Column(
                              children: List.generate(
                                cartNotifier.selectedCartItems.length,
                                (i) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 10.h),
                                    child: CheckoutTile(
                                      cart: cartNotifier.selectedCartItems[i],
                                    ),
                                  );
                                },
                              ),
                            ),

                            SizedBox(height: 100.h),
                          ],
                        ),
                      ),

                      // Checkout button
                      Positioned(
                        bottom: 20,
                        left: 20,
                        right: 20,
                        child: GestureDetector(
                          onTap: () {
                            if (address == null) {
                              context.push('/addresses');
                            } else {
                              List<CartItem> checkoutItems = [];

                              for (var item in cartNotifier.selectedCartItems) {
                                CartItem data = CartItem(
                                  name: item.product.title,
                                  id: item.product.id,
                                  price: item.product.price.roundToDouble(),
                                  cartQuantity: item.quantity,
                                  size: item.size,
                                  color: item.color,
                                );

                                checkoutItems.add(data);
                              }

                              CreateCheckout data = CreateCheckout(
                                address:
                                    context.read<AddressNotifier>().address ==
                                            null
                                        ? address.id
                                        : context
                                            .read<AddressNotifier>()
                                            .address!
                                            .id,
                                accesstoken: accessToken.toString(),
                                fcm: '',
                                totalAmount: cartNotifier.totalPrice,
                                cartItems: checkoutItems,
                              );

                              String c = createCheckoutToJson(data);
                              cartNotifier.createCheckout(c);
                            }
                          },
                          child: Container(
                            height: 55.h,
                            decoration: BoxDecoration(
                              color: address == null
                                  ? Kolors.kGray
                                  : Kolors.kPrimary,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: (address == null
                                          ? Kolors.kGray
                                          : Kolors.kPrimary)
                                      .withOpacity(0.3),
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  address == null
                                      ? IconlyBold.location
                                      : IconlyBold.wallet,
                                  color: Kolors.kWhite,
                                  size: 20.sp,
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  address == null
                                      ? "Chọn địa chỉ giao hàng"
                                      : "Tiến hành thanh toán",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Kolors.kWhite,
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
              },
            ),
          );
  }
}
