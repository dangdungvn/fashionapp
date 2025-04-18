import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/src/products/controller/product_notifier.dart';
import 'package:fashionapp/src/products/models/products_model.dart';
import 'package:fashionapp/src/wishlist/controllers/wishlist_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';

class WishlistStaggeredTileWidget extends HookWidget {
  const WishlistStaggeredTileWidget({
    super.key,
    required this.i,
    required this.product,
    this.onTap,
    this.isLoading,
  });

  final int i;
  final Products product;
  final void Function()? onTap;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ProductNotifier>().setProduct(product);
        context.push('/product/${product.id}');
      },
      child: Container(
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ensure column takes minimum space
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image with love button - Fixed height
              Container(
                height: i % 2 == 0
                    ? 125.h
                    : 145.h, // Reduced height to prevent overflow
                decoration: BoxDecoration(
                  color: Kolors.kOffWhite,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Stack(
                  children: [
                    // Product image
                    CachedNetworkImage(
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      imageUrl: product.imageUrls[0],
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

                    // Heart/favorite button
                    Positioned(
                      right: 10.h,
                      top: 10.h,
                      child: Consumer<WishlistNotifier>(
                        builder: (context, wishlistNotifier, child) {
                          if (isLoading!) {
                            return const Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Kolors.kOffWhite,
                                  strokeWidth: 2,
                                ),
                              ),
                            );
                          }
                          return GestureDetector(
                            onTap: onTap,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Kolors.kWhite.withOpacity(0.9),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Kolors.kDark.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 20,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // Price tag
                    Positioned(
                      left: 10.h,
                      bottom: 10.h,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(
                          color: Kolors.kPrimary,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Kolors.kPrimary.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: GoogleFonts.poppins(
                            color: Kolors.kWhite,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Product details - Smaller padding to fit content
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Take minimum height
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product title
                    Text(
                      product.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp, // Slightly smaller text
                        fontWeight: FontWeight.w600,
                        color: Kolors.kDark,
                      ),
                    ),

                    SizedBox(height: 3.h), // Smaller spacing

                    // Rating - Row takes minimal space
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          AntDesign.star,
                          color: Kolors.kGold,
                          size: 12.sp, // Smaller icon
                        ),
                        SizedBox(width: 3.w), // Smaller spacing
                        Text(
                          product.ratings.toStringAsFixed(1),
                          style: GoogleFonts.poppins(
                            fontSize: 11.sp, // Smaller text
                            color: Kolors.kGray,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
