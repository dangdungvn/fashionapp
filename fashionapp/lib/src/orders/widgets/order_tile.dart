import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/src/orders/models/orders_model.dart';
import 'package:fashionapp/src/reviews/controllers/rating_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class OrderTile extends StatelessWidget {
  final OrdersModel order;

  const OrderTile({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.h),
      decoration: BoxDecoration(
        color: Kolors.kWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Kolors.kDark.withOpacity(0.03),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: List.generate(order.orderProducts.length, (i) {
          final product = order.orderProducts[i];
          return Padding(
            padding: EdgeInsets.only(
                bottom: i == order.orderProducts.length - 1 ? 0 : 15.h),
            child: Row(
              children: [
                // Product image with shadow
                Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Kolors.kDark.withOpacity(0.05),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: product.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Kolors.kOffWhite,
                        highlightColor: Kolors.kWhite,
                        child: Container(
                          color: Kolors.kOffWhite,
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Kolors.kOffWhite,
                        child: const Icon(
                          Icons.error_outline,
                          color: Kolors.kGray,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 15.w),

                // Product details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product title
                      Text(
                        product.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Kolors.kDark,
                        ),
                      ),

                      SizedBox(height: 6.h),

                      // Product variations and price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Variations
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Size and color info
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 2.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Kolors.kPrimaryLight
                                          .withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      "Size: ${product.size}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Kolors.kPrimary,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 2.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Kolors.kSecondaryLight
                                          .withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      "Color: ${product.color}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Kolors.kPrimaryLight,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 8.h),

                              // Review button
                              GestureDetector(
                                onTap: () {
                                  if (!order.rated
                                      .contains(product.productId)) {
                                    context
                                        .read<RatingNotifier>()
                                        .setData(product);
                                    context
                                        .read<RatingNotifier>()
                                        .setId(order.id);
                                    context.push('/review');
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 5.h),
                                  decoration: BoxDecoration(
                                    color:
                                        order.rated.contains(product.productId)
                                            ? Kolors.kGray.withOpacity(0.2)
                                            : Kolors.kPrimary,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      if (!order.rated
                                          .contains(product.productId))
                                        BoxShadow(
                                          color:
                                              Kolors.kPrimary.withOpacity(0.3),
                                          spreadRadius: 0,
                                          blurRadius: 6,
                                          offset: const Offset(0, 2),
                                        ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        order.rated.contains(product.productId)
                                            ? IconlyBold.tick_square
                                            : IconlyBold.star,
                                        color: Kolors.kWhite,
                                        size: 14.sp,
                                      ),
                                      SizedBox(width: 4.w),
                                      Text(
                                        order.rated.contains(product.productId)
                                            ? "Đã đánh giá"
                                            : "Đánh giá",
                                        style: GoogleFonts.poppins(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Kolors.kWhite,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Price and quantity
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // Quantity
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 3.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Kolors.kOffWhite,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Kolors.kGray.withOpacity(0.2),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  "x${product.quantity}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Kolors.kDark,
                                  ),
                                ),
                              ),

                              SizedBox(height: 8.h),

                              // Price
                              Text(
                                "\$${(product.price * product.quantity).toStringAsFixed(2)}",
                                style: GoogleFonts.poppins(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Kolors.kPrimary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
