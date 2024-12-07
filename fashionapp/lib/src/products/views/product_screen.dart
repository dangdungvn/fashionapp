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
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                expandedHeight: 320.h,
                collapsedHeight: 65.h,
                floating: false,
                pinned: true,
                leading: const AppBackButton(),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Consumer<WishlistNotifier>(
                      builder: (context, wishlistNotifier, child) {
                        if (isLoading) {
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
                          size: 30,
                          isLiked: products
                              .map((e) => e.id)
                              .contains(productNotifier.product!.id),
                          circleColor: const CircleColor(
                              start: Color(0xff00ddff), end: Color(0xff0099cc)),
                          bubblesColor: const BubblesColor(
                            dotPrimaryColor: Colors.pink,
                            dotSecondaryColor: Colors.white,
                          ),
                          onTap: (isLiked) async {
                            if (accessToken == null) {
                              loginBottomSheet(context);
                              return false;
                            } else {
                              wishlistNotifier.addRemoveWishlist(
                                  productNotifier.product!.id, () {});
                              Future.delayed(const Duration(milliseconds: 500),
                                  () {
                                refetch();
                              });
                              return !isLiked;
                            }
                          },
                          likeBuilder: (bool isLiked) {
                            return Icon(
                              Icons.favorite,
                              color: isLiked
                                  ? Colors.red
                                  : Colors.grey.withOpacity(0.5),
                              size: 30,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  background: SizedBox(
                    height: 415.h,
                    child: ImageSlideshow(
                      indicatorColor: Kolors.kPrimaryLight,
                      autoPlayInterval: 15000,
                      isLoop: productNotifier.product!.imageUrls.length > 1
                          ? true
                          : false,
                      children: List.generate(
                        productNotifier.product!.imageUrls.length,
                        (i) {
                          return CachedNetworkImage(
                            placeholder: placeholder,
                            errorWidget: errorWidget,
                            height: 415.h,
                            imageUrl: productNotifier.product!.imageUrls[i],
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 10.h,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReusableText(
                        text:
                            productNotifier.product!.clothesType.toUpperCase(),
                        style: appStyle(13, Kolors.kGray, FontWeight.w600),
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
                            text: productNotifier.product!.ratings
                                .toStringAsFixed(1),
                            style:
                                appStyle(13, Kolors.kGray, FontWeight.normal),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 10.h,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ReusableText(
                    text: productNotifier.product!.title,
                    style: appStyle(16, Kolors.kDark, FontWeight.w600),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(8.h),
                  child: ExpandableText(
                      text: productNotifier.product!.description),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Divider(
                    thickness: .5.h,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 10.h,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ReusableText(
                    text: "Select Sizes",
                    style: appStyle(14, Kolors.kDark, FontWeight.w600),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ProductSizesWidget(),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 10.h,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ReusableText(
                    text: "Select Color",
                    style: appStyle(14, Kolors.kDark, FontWeight.w600),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ColorColectionWidget(),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 10.h,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ReusableText(
                    text: "Similar Products",
                    style: appStyle(14, Kolors.kDark, FontWeight.w600),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SimilarProducts(),
              ),
            ],
          ),
          bottomNavigationBar: ProductBottomBar(
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
        );
      },
    );
  }
}
