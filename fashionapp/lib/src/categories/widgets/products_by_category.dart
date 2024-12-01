import 'package:fashionapp/common/widgets/empty_screen_widget.dart';
import 'package:fashionapp/common/widgets/shimmers/list_shimmer.dart';
import 'package:fashionapp/src/categories/controllers/category_notifier.dart';
import 'package:fashionapp/src/categories/hooks/fetch_products_by_category.dart';
import 'package:fashionapp/src/wishlist/controllers/wishlist_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/common/widgets/login_bottom_sheet.dart';
import 'package:fashionapp/src/products/widgets/staggered_tile_widget.dart';
import 'package:provider/provider.dart';

class ProductsByCategory extends HookWidget {
  const ProductsByCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    final results =
        fetchProductsByCategories(context.read<CategoryNotifier>().id);
    final products = results.products;
    final isLoading = results.isLoading;
    // final error = results.error;
    if (isLoading) {
      return const Scaffold(
        body: ListShimmer(),
      );
    } else {}
    return products.isEmpty
        ? const EmptyScreenWidget()
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.h),
            child: StaggeredGrid.count(
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              crossAxisCount: 4,
              children: List.generate(
                products.length,
                (i) {
                  final double mainAxisCellCount = (i % 2 == 0 ? 2.17 : 2.4);
                  final product = products[i];
                  return StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: mainAxisCellCount,
                    child: Padding(
                      padding: i % 2 == 0
                          ? EdgeInsets.only(right: 2.w)
                          : EdgeInsets.only(left: 2.w),
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
                      ),
                    ),
                  );
                },
              ),
            ),
          );
  }
}
