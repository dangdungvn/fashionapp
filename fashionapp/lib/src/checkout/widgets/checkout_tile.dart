import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/src/cart/controllers/cart_notifier.dart';
import 'package:fashionapp/src/cart/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CheckoutTile extends StatelessWidget {
  const CheckoutTile({
    super.key,
    required this.cart,
  });
  final CartModel cart;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartNotifier>(
      builder: (context, cartNotifier, child) {
        return Container(
          width: ScreenUtil().screenWidth,
          decoration: BoxDecoration(
            color: Kolors.kWhite,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Kolors.kDark.withOpacity(0.03),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(8.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Product image with shadow and rounded corners
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
                      imageUrl: cart.product.imageUrls[0],
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Product title
                      Text(
                        cart.product.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Kolors.kDark,
                        ),
                      ),

                      SizedBox(height: 5.h),

                      // Product variations (Size & Color)
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: Kolors.kPrimaryLight.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Size: ${cart.size}",
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
                              color: Kolors.kSecondaryLight.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Color: ${cart.color}",
                              style: GoogleFonts.poppins(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                                color: Kolors.kPrimaryLight,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Price and quantity
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Quantity indicator
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: Kolors.kOffWhite,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Kolors.kPrimary.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        "x${cart.quantity}",
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Kolors.kPrimary,
                        ),
                      ),
                    ),

                    SizedBox(height: 8.h),

                    // Price
                    Text(
                      "\$${(cart.product.price * cart.quantity).toStringAsFixed(2)}",
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: Kolors.kDark,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
