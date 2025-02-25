import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: Kolors.kOffWhite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: i % 2 == 0 ? 158.h : 180.h,
                color: Kolors.kOffWhite,
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      width: double.infinity,
                      height: i % 2 == 0 ? 158.h : 180.h,
                      fit: BoxFit.cover,
                      imageUrl: product.imageUrls[0],
                      placeholder: (context, url) => Lottie.asset(
                          R.ASSETS_ANIMATIONS_LOADING_JSON,
                          height: 50,
                          width: 50),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Consumer<WishlistNotifier>(
                        builder: (context, wishlistNotifier, child) {
                          if (wishlistIsLoading!) {
                            return const Center(
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Kolors.kOffWhite,
                                ),
                              ),
                            );
                          }
                          return LikeButton(
                            size: 25,
                            isLiked: wishlistProduct!
                                .map((e) => e.id)
                                .contains(product.id),
                            circleColor: const CircleColor(
                                start: Color(0xff00ddff),
                                end: Color(0xff0099cc)),
                            bubblesColor: const BubblesColor(
                              dotPrimaryColor: Colors.pink,
                              dotSecondaryColor: Colors.white,
                            ),
                            onTap: (isLiked) async {
                              wishlistNotifier.addRemoveWishlist(
                                  product.id, wishlistRefetch!);
                              return !isLiked;
                            },
                            likeBuilder: (bool isLiked) {
                              return Icon(
                                Icons.favorite,
                                color: isLiked
                                    ? Colors.red
                                    : Colors.grey.withOpacity(0.5),
                                size: 25,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Text(
                        product.title,
                        overflow: TextOverflow.ellipsis,
                        style: appStyle(13, Kolors.kDark, FontWeight.w600),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          AntDesign.star,
                          color: Kolors.kGold,
                          size: 14,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        ReusableText(
                            text: product.ratings.toStringAsFixed(1),
                            style:
                                appStyle(13, Kolors.kGray, FontWeight.normal))
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: ReusableText(
                    text: '\$ ${product.price.toStringAsFixed(2)}',
                    style: appStyle(17, Kolors.kDark, FontWeight.w500)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
