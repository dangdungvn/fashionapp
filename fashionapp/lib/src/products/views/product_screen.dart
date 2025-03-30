import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/back_button.dart';
import 'package:fashionapp/common/widgets/error_modal.dart';
import 'package:fashionapp/common/widgets/login_bottom_sheet.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/const/constants.dart';
import 'package:fashionapp/src/cart/controllers/cart_notifier.dart';
import 'package:fashionapp/src/cart/models/create_cart_model.dart';
import 'package:fashionapp/src/products/controller/colors_sizes_notifier.dart';
import 'package:fashionapp/src/products/controller/product_notifier.dart';
import 'package:fashionapp/src/products/widgets/color_colection_widget.dart';
import 'package:fashionapp/src/products/widgets/expandable_text.dart';
import 'package:fashionapp/src/products/widgets/product_bottom_bar.dart';
import 'package:fashionapp/src/products/widgets/product_sizes_widget.dart';
import 'package:fashionapp/src/products/widgets/similar_products.dart';
import 'package:fashionapp/src/wishlist/controllers/wishlist_notifier.dart';
import 'package:fashionapp/src/wishlist/hooks/fetch_wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:like_button/like_button.dart';

class ProductPage extends HookWidget {
  const ProductPage({super.key, required this.productId});
  final String productId;

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    final results = fetchWishlist();
    final products = results.products;
    final isLoading = results.isLoading;
    final refetch = results.refetch;

    return Consumer<ProductNotifier>(
      builder: (context, productNotifier, child) {
        return Scaffold(
          backgroundColor: Kolors.kOffWhite,
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Image slider with refined AppBar
              SliverAppBar(
                backgroundColor: Kolors.kOffWhite,
                expandedHeight: 350.h,
                collapsedHeight: 65.h,
                floating: false,
                pinned: true,
                elevation: 0,
                surfaceTintColor: Colors.transparent,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Kolors.kWhite.withOpacity(0.9),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Kolors.kDark.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: const AppBackButton(),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Kolors.kWhite.withOpacity(0.9),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Kolors.kDark.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Consumer<WishlistNotifier>(
                        builder: (context, wishlistNotifier, child) {
                          if (isLoading) {
                            return const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 20,
                                width: 20,
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
                            isLiked: products
                                .map((e) => e.id)
                                .contains(productNotifier.product!.id),
                            circleColor: const CircleColor(
                              start: Kolors.kRed,
                              end: Kolors.kRed,
                            ),
                            bubblesColor: BubblesColor(
                              dotPrimaryColor: Kolors.kRed,
                              dotSecondaryColor: Kolors.kRed.withOpacity(0.5),
                            ),
                            onTap: (isLiked) async {
                              if (accessToken == null) {
                                loginBottomSheet(context);
                                return false;
                              } else {
                                wishlistNotifier.addRemoveWishlist(
                                    productNotifier.product!.id, () {});
                                Future.delayed(
                                    const Duration(milliseconds: 500), () {
                                  refetch();
                                });
                                return !isLiked;
                              }
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
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: 'product_${productNotifier.product!.id}',
                    child: Container(
                      decoration: BoxDecoration(
                        color: Kolors.kWhite,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Kolors.kDark.withOpacity(0.05),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        child: ImageSlideshow(
                          indicatorColor: Kolors.kPrimary,
                          indicatorBackgroundColor: Kolors.kWhite,
                          indicatorRadius: 4,
                          autoPlayInterval: 15000,
                          isLoop: productNotifier.product!.imageUrls.length > 1,
                          children: List.generate(
                            productNotifier.product!.imageUrls.length,
                            (i) {
                              return CachedNetworkImage(
                                placeholder: placeholder,
                                errorWidget: errorWidget,
                                imageUrl: productNotifier.product!.imageUrls[i],
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Product content in a card container
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(
                    top: 15.h,
                    left: 15.w,
                    right: 15.w,
                    bottom: 5.h,
                  ),
                  padding: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                    color: Kolors.kWhite,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Kolors.kDark.withOpacity(0.03),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product type and rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 5.h,
                            ),
                            decoration: BoxDecoration(
                              color: Kolors.kPrimaryLight.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              productNotifier.product!.clothesType
                                  .toUpperCase(),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Kolors.kPrimary,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 5.h,
                            ),
                            decoration: BoxDecoration(
                              color: Kolors.kGold.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  AntDesign.star,
                                  color: Kolors.kGold,
                                  size: 14,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  productNotifier.product!.ratings
                                      .toStringAsFixed(1),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Kolors.kGold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 15.h),

                      // Product title
                      Text(
                        productNotifier.product!.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Kolors.kDark,
                        ),
                      ),

                      SizedBox(height: 5.h),

                      // Price
                      Text(
                        "\$${productNotifier.product!.price.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Kolors.kPrimary,
                        ),
                      ),

                      SizedBox(height: 15.h),

                      // Description
                      ExpandableText(
                          text: productNotifier.product!.description),
                    ],
                  ),
                ),
              ),

              // Product options (Sizes)
              SliverToBoxAdapter(
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                  padding: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                    color: Kolors.kWhite,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Kolors.kDark.withOpacity(0.03),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Select Size",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Kolors.kDark,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      const ProductSizesWidget(),
                    ],
                  ),
                ),
              ),

              // Colors
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                  padding: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                    color: Kolors.kWhite,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Kolors.kDark.withOpacity(0.03),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Select Color",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Kolors.kDark,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      ColorColectionWidget(),
                    ],
                  ),
                ),
              ),

              // Similar Products
              SliverToBoxAdapter(
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                  padding: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                    color: Kolors.kWhite,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Kolors.kDark.withOpacity(0.03),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Similar Products",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Kolors.kDark,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      const SimilarProducts(),
                    ],
                  ),
                ),
              ),

              // Bottom padding for cart button
              SliverToBoxAdapter(
                child: SizedBox(height: 80.h),
              ),
            ],
          ),

          // Bottom bar for add to cart
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Kolors.kWhite,
              boxShadow: [
                BoxShadow(
                  color: Kolors.kDark.withOpacity(0.05),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: const Offset(0, -5),
                ),
              ],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: ProductBottomBar(
              price: productNotifier.product!.price.toStringAsFixed(2),
              onPressed: () {
                if (accessToken == null) {
                  loginBottomSheet(context);
                } else {
                  if (context.read<ColorsSizesNotifier>().colors == '' ||
                      context.read<ColorsSizesNotifier>().sizes == '') {
                    showErrorPopup(context, AppText.kCartErrorText,
                        "Error Adding to Cart", true);
                  } else {
                    CreateCartModel data = CreateCartModel(
                      product: context.read<ProductNotifier>().product!.id,
                      quantity: 1,
                      color: context.read<ColorsSizesNotifier>().colors,
                      size: context.read<ColorsSizesNotifier>().sizes,
                    );
                    String cartData = createCartModelToJson(data);
                    context.read<CartNotifier>().addToCart(cartData, context);
                  }
                }
              },
            ),
          ),
        );
      },
    );
  }
}
