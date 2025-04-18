import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/const/resource.dart';
import 'package:fashionapp/src/products/controller/product_notifier.dart';
import 'package:fashionapp/src/products/models/products_model.dart';
import 'package:fashionapp/src/wishlist/controllers/wishlist_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:like_button/like_button.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class StaggeredTileWidget extends HookWidget {
  const StaggeredTileWidget({
    super.key,
    required this.i,
    required this.product,
    this.onTap,
    this.wishlistProduct,
    this.wishlistIsLoading,
    this.wishlistRefetch,
  });
  final int i;
  final Products product;
  final void Function()? onTap;
  final List<Products>? wishlistProduct;
  final bool? wishlistIsLoading;
  final Function()? wishlistRefetch;

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
              color: Kolors.kDark.withOpacity(0.05),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Phần hình ảnh sản phẩm
              Container(
                height: i % 2 == 0 ? 112.h : 123.h,
                decoration: const BoxDecoration(
                  color: Kolors.kOffWhite,
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Hình ảnh sản phẩm
                    Hero(
                      tag: 'product_${product.id}',
                      child: CachedNetworkImage(
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        imageUrl: product.imageUrls[0],
                        placeholder: (context, url) => Center(
                          child: Lottie.asset(
                            R.ASSETS_ANIMATIONS_LOADING_JSON,
                            height: 50,
                            width: 50,
                          ),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.image_not_supported_outlined,
                          color: Kolors.kGray,
                        ),
                      ),
                    ),

                    // Gradient overlay ở phần dưới để làm nổi bật mức giá
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Kolors.kDark.withOpacity(0.5),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Nút thích
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
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
                        child: Consumer<WishlistNotifier>(
                          builder: (context, wishlistNotifier, child) {
                            if (wishlistIsLoading!) {
                              return const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Kolors.kPrimary,
                                  ),
                                ),
                              );
                            }
                            return LikeButton(
                              size: 20,
                              padding: const EdgeInsets.all(8),
                              isLiked: wishlistProduct!
                                  .map((e) => e.id)
                                  .contains(product.id),
                              circleColor: const CircleColor(
                                start: Kolors.kRed,
                                end: Kolors.kRed,
                              ),
                              bubblesColor: BubblesColor(
                                dotPrimaryColor: Kolors.kRed,
                                dotSecondaryColor: Kolors.kRed.withOpacity(0.5),
                              ),
                              onTap: (isLiked) async {
                                wishlistNotifier.addRemoveWishlist(
                                  product.id,
                                  wishlistRefetch!,
                                );
                                return !isLiked;
                              },
                              likeBuilder: (bool isLiked) {
                                return Icon(
                                  isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isLiked ? Kolors.kRed : Kolors.kGray,
                                  size: 20,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),

                    // Hiển thị giá ở góc dưới
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Kolors.kWhite.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Kolors.kPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Phần thông tin sản phẩm
              Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tên sản phẩm
                    Text(
                      product.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Kolors.kDark,
                      ),
                    ),

                    SizedBox(height: 5.h),

                    // Hiển thị rating và số lượt đánh giá
                    Row(
                      children: [
                        const Icon(
                          AntDesign.star,
                          color: Kolors.kGold,
                          size: 14,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          product.ratings.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Kolors.kGray,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          '• ${product.clothesType}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Kolors.kGray,
                            fontWeight: FontWeight.w400,
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
