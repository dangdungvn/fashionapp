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
        final bool isSelected =
            cartNotifier.selectedCartItemsId.contains(cart.id);

        return GestureDetector(
          onTap: () {
            cartNotifier.selectOrDeselect(cart.id, cart);
          },
          child: Padding(
            padding: EdgeInsets.only(bottom: 10.h),
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
                    backgroundColor: Kolors.kRed,
                    foregroundColor: Kolors.kWhite,
                    autoClose: true,
                    label: "Delete",
                    borderRadius: BorderRadius.circular(16),
                  )
                ],
              ),
              child: Container(
                width: double.infinity,
                height: 105.h,
                decoration: BoxDecoration(
                  color: Kolors.kWhite,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Kolors.kDark.withOpacity(0.05),
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  border: isSelected
                      ? Border.all(color: Kolors.kPrimary, width: 2)
                      : null,
                ),
                child: Row(
                  children: [
                    // Checkbox indicator
                    Container(
                      width: 30.w,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Kolors.kPrimaryLight.withOpacity(0.2)
                            : Colors.transparent,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                      child: Center(
                        child: Checkbox(
                          value: isSelected,
                          onChanged: (_) {
                            cartNotifier.selectOrDeselect(cart.id, cart);
                          },
                          shape: const CircleBorder(),
                          activeColor: Kolors.kPrimary,
                          checkColor: Kolors.kWhite,
                        ),
                      ),
                    ),

                    // Product image
                    Container(
                      width: 85.w,
                      height: 85.h,
                      margin: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Kolors.kOffWhite,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedNetworkImage(
                          imageUrl: cart.product.imageUrls[0],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // Product details
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 8.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Product name
                            Text(
                              cart.product.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Kolors.kDark,
                              ),
                            ),

                            SizedBox(height: 5.h),

                            // Product options (size & color)
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 3.h),
                                  decoration: BoxDecoration(
                                    color: Kolors.kGrayLight.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    "Size: ${cart.size}",
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Kolors.kGray,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 6.w),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 3.h),
                                  decoration: BoxDecoration(
                                    color: Kolors.kGrayLight.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    "Color: ${cart.color}",
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Kolors.kGray,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 10.h),

                            // Price and quantity controller
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Price
                                Text(
                                  "\$${(cart.product.price * cart.quantity).toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Kolors.kPrimary,
                                  ),
                                ),

                                // Quantity control
                                cartNotifier.selectedCart != null &&
                                        cartNotifier.selectedCart == cart.id
                                    ? Row(
                                        children: [
                                          const CartCounter(),
                                          SizedBox(width: 8.w),
                                          UpdateButton(onUpdate: onUpdate),
                                        ],
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          cartNotifier.setSelectedCounter(
                                              cart.id, cart.quantity);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w, vertical: 6.h),
                                          decoration: BoxDecoration(
                                            color: Kolors.kPrimaryLight
                                                .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.edit,
                                                size: 14,
                                                color: Kolors.kPrimary,
                                              ),
                                              SizedBox(width: 4.w),
                                              Text(
                                                "Qty: ${cart.quantity}",
                                                style: const TextStyle(
                                                  fontSize: 12,
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
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
