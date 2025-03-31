import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/empty_screen_widget.dart';
import 'package:fashionapp/common/widgets/login_bottom_sheet.dart';
import 'package:fashionapp/src/products/controller/product_notifier.dart';
import 'package:fashionapp/src/products/hooks/fetch_similar.dart';
import 'package:fashionapp/src/products/widgets/staggered_tile_widget.dart';
import 'package:fashionapp/src/wishlist/controllers/wishlist_notifier.dart';
import 'package:fashionapp/src/wishlist/hooks/fetch_wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class SimilarProducts extends HookWidget {
  const SimilarProducts({super.key});

  @override
  Widget build(BuildContext context) {
    // Tính toán số lượng sản phẩm hiển thị dựa trên chiều rộng màn hình
    final screenWidth = MediaQuery.of(context).size.width;
    final productWidth = 160.w;
    final itemsPerScreen = (screenWidth / productWidth).floor();

    String? accessToken = Storage().getString('accessToken');
    final results =
        fetchSimilar(context.read<ProductNotifier>().product!.category);
    final products = results.products;
    final isLoading = results.isLoading;
    final resultsWishlist = fetchWishlist();
    final wishlistProduct = resultsWishlist.products;
    final isLoadingWishlist = resultsWishlist.isLoading;
    final refetchWishlist = resultsWishlist.refetch;

    if (isLoading) {
      // Shimmer với chiều cao tỉ lệ với màn hình
      return SizedBox(
        height:
            0.27.sh, // Sử dụng tỉ lệ chiều cao màn hình thay vì giá trị cố định
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: itemsPerScreen, // Số lượng shimmer thích ứng với màn hình
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Kolors.kGrayLight.withOpacity(0.3),
              highlightColor: Kolors.kWhite,
              child: Container(
                width: productWidth,
                margin: EdgeInsets.only(right: 15.w),
                decoration: BoxDecoration(
                  color: Kolors.kWhite,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            );
          },
        ),
      );
    }

    if (products.isEmpty) {
      return const EmptyScreenWidget();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header với nút xem tất cả
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Sản phẩm tương tự",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Kolors.kDark,
                ),
              ),
              // Nút xem tất cả
              GestureDetector(
                onTap: () {
                  // TODO: Navigate to similar products page
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: Kolors.kPrimaryLight.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Row(
                    children: [
                      Text(
                        "Xem thêm",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Kolors.kPrimary,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 10,
                        color: Kolors.kPrimary,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15.h),
        // Danh sách sản phẩm ngang với chiều cao responsive
        SizedBox(
          height: 0.27
              .sh, // Chiều cao dựa trên tỉ lệ màn hình thay vì giá trị cố định
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: products.length,
            itemBuilder: (context, i) {
              final product = products[i];
              final bool isWishlisted =
                  wishlistProduct.map((e) => e.id).contains(product.id);
              return GestureDetector(
                onTap: () {
                  context.read<ProductNotifier>().setProduct(product);
                  context.push('/product/${product.id}');
                },
                child: Container(
                  width: productWidth,
                  margin: EdgeInsets.only(right: 15.w, left: i == 0 ? 8.w : 0),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Hình ảnh sản phẩm
                      Stack(
                        children: [
                          // Hình sản phẩm
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: product.imageUrls[0],
                              height:
                                  0.17.sh, // Chiều cao dựa trên tỉ lệ màn hình
                              width: double.infinity,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Kolors.kPrimary,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Center(
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  color: Kolors.kGray,
                                ),
                              ),
                            ),
                          ),

                          // Price tag
                          Positioned(
                            bottom: 8,
                            left: 8,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: Kolors.kWhite.withOpacity(0.85),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                "\$${product.price.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Kolors.kPrimary,
                                ),
                              ),
                            ),
                          ),

                          // Wishlist button
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () {
                                if (accessToken == null) {
                                  loginBottomSheet(context);
                                } else {
                                  context
                                      .read<WishlistNotifier>()
                                      .addRemoveWishlist(
                                          product.id, refetchWishlist);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Kolors.kWhite.withOpacity(0.85),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  isWishlisted
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color:
                                      isWishlisted ? Kolors.kRed : Kolors.kGray,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Product info
                      Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product title
                            Text(
                              product.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Kolors.kDark,
                              ),
                            ),

                            SizedBox(height: 5.h),

                            // Product details
                            Row(
                              children: [
                                // Rating
                                const Icon(
                                  Icons.star,
                                  color: Kolors.kGold,
                                  size: 13,
                                ),
                                SizedBox(width: 3.w),
                                Text(
                                  "${product.ratings}",
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: Kolors.kGray,
                                  ),
                                ),

                                SizedBox(width: 10.w),

                                // Category
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6.w,
                                    vertical: 2.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Kolors.kGrayLight.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    product.category.toString(),
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Kolors.kGray,
                                    ),
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
              );
            },
          ),
        ),
      ],
    );
  }
}
