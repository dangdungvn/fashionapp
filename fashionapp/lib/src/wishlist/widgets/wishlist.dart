import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/common/widgets/empty_screen_widget.dart';
import 'package:fashionapp/common/widgets/login_bottom_sheet.dart';
import 'package:fashionapp/common/widgets/shimmers/list_shimmer.dart';
import 'package:fashionapp/src/wishlist/controllers/wishlist_notifier.dart';
import 'package:fashionapp/src/wishlist/hooks/fetch_wishlist.dart';
import 'package:fashionapp/src/wishlist/widgets/wishlist_staggered_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class WishListWidget extends HookWidget {
  const WishListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    final results = fetchWishlist();
    final products = results.products;
    final isLoading = results.isLoading;
    final refetch = results.refetch;

    if (isLoading) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: const ListShimmer(),
      );
    }

    return products.isEmpty
        ? const EmptyScreenWidget()
        : ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.h),
                child: StaggeredGrid.count(
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  crossAxisCount: 4,
                  children: List.generate(
                    products.length,
                    (i) {
                      final double mainAxisCellCount =
                          (i % 2 == 0 ? 2.17 : 2.4);
                      final product = products[i];
                      return StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: mainAxisCellCount,
                        child: Padding(
                          padding: i % 2 == 0
                              ? EdgeInsets.only(right: 2.w)
                              : EdgeInsets.only(left: 2.w),
                          child: WishlistStaggeredTileWidget(
                            onTap: () {
                              if (accessToken == null) {
                                loginBottomSheet(context);
                              } else {
                                context
                                    .read<WishlistNotifier>()
                                    .addRemoveWishlist(product.id, refetch);
                              }
                              // Future.delayed(const Duration(seconds: 1));
                            },
                            i: i,
                            product: product,
                            isLoading: isLoading,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 100.h,
              ),
            ],
          );
  }
}
