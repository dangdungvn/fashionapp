import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/login_bottom_sheet.dart';
import 'package:fashionapp/common/widgets/shimmers/list_shimmer.dart';
import 'package:fashionapp/const/resource.dart';
import 'package:fashionapp/src/home/controller/home_tab_notifier.dart';
import 'package:fashionapp/src/products/hooks/fetch_products.dart';
import 'package:fashionapp/src/products/widgets/staggered_tile_widget.dart';
import 'package:fashionapp/src/wishlist/controllers/wishlist_notifier.dart';
import 'package:fashionapp/src/wishlist/hooks/fetch_wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class ExploreProducts extends HookWidget {
  const ExploreProducts({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    final results = fetchProducts(context.watch<HomeTabNotifier>().queryType);
    final products = results.products;
    final isLoading = results.isLoading;
    final resultsWishlist = fetchWishlist();
    final wishlistProduct = resultsWishlist.products;
    final isLoadingWishlist = resultsWishlist.isLoading;
    final refetchWishlist = resultsWishlist.refetch;

    // Header for products section with modern design
    Widget header = Container(
      margin: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Sản phẩm nổi bật",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Kolors.kDark,
              letterSpacing: 0.5,
            ),
          ),
          GestureDetector(
            onTap: () {
              // Navigate to all products page
              context.push('/all-products');
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Kolors.kPrimaryLight.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Text(
                    "Xem tất cả",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Kolors.kPrimary,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  const Icon(
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
    );

    if (isLoading) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: const ListShimmer(),
          ),
        ],
      );
    }

    if (products.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header,
          Container(
            margin: EdgeInsets.symmetric(vertical: 30.h),
            alignment: Alignment.center,
            child: Column(
              children: [
                Image.asset(
                  R.ASSETS_IMAGES_EMPTY_PNG,
                  height: ScreenUtil().screenHeight * 0.2,
                ),
                SizedBox(height: 15.h),
                const Text(
                  "Không tìm thấy sản phẩm nào",
                  style: TextStyle(
                    color: Kolors.kGray,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: Kolors.kPrimaryLight.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Thử lại với danh mục khác",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Kolors.kPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        header,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: StaggeredGrid.count(
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            crossAxisCount: 4,
            children: List.generate(
              products.length,
              (i) {
                final double mainAxisCellCount = (i % 2 == 0 ? 2.17 : 2.4);
                final product = products[i];
                return StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: mainAxisCellCount,
                  child: StaggeredTileWidget(
                    onTap: () {
                      if (accessToken == null) {
                        loginBottomSheet(context);
                      } else {
                        context
                            .read<WishlistNotifier>()
                            .addRemoveWishlist(product.id, () {});
                      }
                    },
                    i: i,
                    product: product,
                    wishlistIsLoading: isLoadingWishlist,
                    wishlistProduct: wishlistProduct,
                    wishlistRefetch: refetchWishlist,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
