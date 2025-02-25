import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/const/constants.dart';
import 'package:fashionapp/src/cart/controllers/cart_notifier.dart';
import 'package:fashionapp/src/cart/models/cart_model.dart';
import 'package:fashionapp/src/cart/widgets/cart_counter.dart';
import 'package:fashionapp/src/cart/widgets/update_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class CartTile extends StatelessWidget {
  const CartTile({
    super.key,
    required this.cart,
    this.onDelete,
    this.onUpdate,
  });
  final CartModel cart;
  final void Function()? onDelete;
  final void Function()? onUpdate;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartNotifier>(
      builder: (context, cartNotifier, child) {
        return GestureDetector(
          onTap: () {
            cartNotifier.selectOrDeselect(cart.id, cart);
          },
          child: Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Slidable(
              endActionPane: ActionPane(
                motion: const StretchMotion(),
                extentRatio: 0.2,
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      onDelete!();
                    },
                    icon: Icons.delete,
                    backgroundColor: Colors.red.shade300,
                    foregroundColor: Kolors.kWhite,
                    autoClose: true,
                    label: "Del",
                    borderRadius: BorderRadius.circular(12),
                  )
                ],
              ),
              child: Container(
                width: ScreenUtil().screenWidth,
                height: 90.h,
                decoration: BoxDecoration(
                  color: !cartNotifier.selectedCartItemsId.contains(cart.id)
                      ? Kolors.kWhite
                      : Kolors.kPrimaryLight.withOpacity(0.1),
                  borderRadius: kRadiusAll,
                ),
                child: SizedBox(
                  height: 85.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Kolors.kWhite,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: kRadiusAll,
                              child: SizedBox(
                                width: 76.w,
                                height: double.infinity,
                                child: CachedNetworkImage(
                                  imageUrl: cart.product.imageUrls[0],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ReusableText(
                                text: cart.product.title,
                                style: appStyle(
                                    12, Kolors.kPrimary, FontWeight.normal),
                              ),
                              ReusableText(
                                text:
                                    "Size: ${cart.size}   ||   Color: ${cart.color}",
                                style: appStyle(
                                    12, Kolors.kGray, FontWeight.normal),
                              ),
                              // SizedBox(
                              //   width: ScreenUtil().screenWidth * 0.5,
                              //   child: Text(
                              //     cart.product.description,
                              //     maxLines: 2,
                              //     textAlign: TextAlign.justify,
                              //     style: appStyle(
                              //         9, Kolors.kGray, FontWeight.normal),
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            cartNotifier.selectedCart != null &&
                                    cartNotifier.selectedCart == cart.id
                                ? const CartCounter()
                                : GestureDetector(
                                    onTap: () {
                                      cartNotifier.setSelectedCounter(
                                          cart.id, cart.quantity);
                                    },
                                    onDoubleTap: () {},
                                    child: Container(
                                      width: 40.w,
                                      height: 20.h,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Kolors.kPrimary,
                                          width: 0.5.w,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      child: ReusableText(
                                        text: "* ${cart.quantity}",
                                        style: appStyle(12, Kolors.kPrimary,
                                            FontWeight.normal),
                                      ),
                                    ),
                                  ),
                            SizedBox(height: 6.h),
                            cartNotifier.selectedCart != null &&
                                    cartNotifier.selectedCart == cart.id
                                ? UpdateButton(
                                    onUpdate: onUpdate,
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(right: 6.w),
                                    child: ReusableText(
                                      text:
                                          "\$ ${(cart.product.price * cart.quantity).toStringAsFixed(2)}",
                                      style: appStyle(
                                          12, Kolors.kPrimary, FontWeight.w600),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
