import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/back_button.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
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
            appBar: AppBar(
              leading: AppBackButton(
                onTap: () {
                  // clear the address
                  context.read<AddressNotifier>().clearAddress();
                  context.pop();
                },
              ),
              centerTitle: true,
              title: ReusableText(
                text: AppText.kCheckout,
                style: appStyle(16, Kolors.kPrimary, FontWeight.bold),
              ),
            ),
            body: Consumer<CartNotifier>(
              builder: (context, cartNotifier, child) {
                return Stack(children: [
                  ListView(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    children: [
                      isLoading
                          ? const SizedBox.shrink()
                          : AddressBlock(
                              address: address,
                            ),
                      SizedBox(height: 10.h),
                      SizedBox(
                        // height: ScreenUtil().scaleHeight * 0.6,
                        child: Column(
                          children: List.generate(
                            cartNotifier.selectedCartItems.length,
                            (i) {
                              return CheckoutTile(
                                cart: cartNotifier.selectedCartItems[i],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 20,
                    left: 50,
                    right: 50,
                    child: Consumer<CartNotifier>(
                      builder: (context, cartNotifier, child) {
                        return GestureDetector(
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
                                    color: item.color);

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
                                  cartItems: checkoutItems);

                              String c = createCheckoutToJson(data);

                              cartNotifier.createCheckout(c);
                            }
                          },
                          child: Container(
                            height: 50.h,
                            width: ScreenUtil().scaleWidth,
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
                            child: Center(
                              child: ReusableText(
                                text: address == null
                                    ? "Please an Address"
                                    : "Continue to Payment",
                                style: appStyle(
                                    16, Kolors.kWhite, FontWeight.w500),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ]);
              },
            ),
          );
  }
}
