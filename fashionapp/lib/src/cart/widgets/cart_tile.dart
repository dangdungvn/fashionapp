import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/src/cart/controllers/cart_notifier.dart';
import 'package:fashionapp/src/cart/models/cart_model.dart';
import 'package:fashionapp/src/cart/widgets/cart_counter.dart';
import 'package:fashionapp/src/cart/widgets/update_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
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
    // final screenWidth = MediaQuery.of(context).size.width;

    return Consumer<CartNotifier>(
      builder: (context, cartNotifier, child) {
        final bool isSelected =
            cartNotifier.selectedCartItemsId.contains(cart.id);

        return GestureDetector(
          onTap: () {
            cartNotifier.selectOrDeselect(cart.id, cart);
          },
          child: Padding(
            padding: EdgeInsets.only(bottom: 12.h),
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
                    label: "Xóa",
                    borderRadius: BorderRadius.circular(16.r),
                  )
                ],
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Kolors.kWhite,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Kolors.kDark.withOpacity(0.05),
                      blurRadius: 8,
                      spreadRadius: 1,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  border: isSelected
                      ? Border.all(color: Kolors.kPrimary, width: 1.5)
                      : null,
                ),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Checkbox indicator
                      SizedBox(
                        width: 36.w,
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Kolors.kPrimaryLight.withOpacity(0.2)
                                : Colors.transparent,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.r),
                              bottomLeft: Radius.circular(16.r),
                            ),
                          ),
                          child: Center(
                            child: Transform.scale(
                              scale: 0.9,
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
                        ),
                      ),

                      // Product image
                      Container(
                        width: 70.w,
                        height: 70.w,
                        margin: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: Kolors.kOffWhite,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: CachedNetworkImage(
                            imageUrl: cart.product.imageUrls[0],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      // Product details
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 6.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Product name and options in a column
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Product name
                                  Text(
                                    cart.product.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Kolors.kDark,
                                    ),
                                  ),

                                  SizedBox(height: 4.h),

                                  // Product options (size & color)
                                  Wrap(
                                    spacing: 6.w,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 6.w, vertical: 2.h),
                                        decoration: BoxDecoration(
                                          color: Kolors.kGrayLight
                                              .withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(4.r),
                                        ),
                                        child: Text(
                                          "Size: ${cart.size}",
                                          style: GoogleFonts.poppins(
                                            fontSize: 10.sp,
                                            color: Kolors.kGray,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 6.w, vertical: 2.h),
                                        decoration: BoxDecoration(
                                          color: Kolors.kGrayLight
                                              .withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(4.r),
                                        ),
                                        child: Text(
                                          "Color: ${cart.color}",
                                          style: GoogleFonts.poppins(
                                            fontSize: 10.sp,
                                            color: Kolors.kGray,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // Price and quantity controller
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Dynamic layout based on screen size and selection state
                                  if (cartNotifier.selectedCart != null &&
                                      cartNotifier.selectedCart == cart.id)
                                    // When cart item is selected for quantity editing
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Price
                                        Text(
                                          "\$${(cart.product.price * cart.quantity).toStringAsFixed(2)}",
                                          style: GoogleFonts.poppins(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Kolors.kPrimary,
                                          ),
                                        ),

                                        SizedBox(height: 6.h),

                                        // Counter and update button
                                        Row(
                                          children: [
                                            const CartCounter(),
                                            SizedBox(width: 8.w),
                                            UpdateButton(onUpdate: onUpdate),
                                          ],
                                        ),
                                      ],
                                    )
                                  else
                                    // Regular view when not editing quantity
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Price
                                        Text(
                                          "\$${(cart.product.price * cart.quantity).toStringAsFixed(2)}",
                                          style: GoogleFonts.poppins(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Kolors.kPrimary,
                                          ),
                                        ),

                                        // Quantity display button
                                        GestureDetector(
                                          onTap: () {
                                            cartNotifier.setSelectedCounter(
                                                cart.id, cart.quantity);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.w, vertical: 4.h),
                                            decoration: BoxDecoration(
                                              color: Kolors.kPrimaryLight
                                                  .withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.edit,
                                                  size: 13.sp,
                                                  color: Kolors.kPrimary,
                                                ),
                                                SizedBox(width: 4.w),
                                                Text(
                                                  "Qty: ${cart.quantity}",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 11.sp,
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
                            ],
                          ),
                        ),
                      ),

                      // Right padding
                      SizedBox(width: 6.w),
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
