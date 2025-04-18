import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/login_bottom_sheet.dart';
import 'package:fashionapp/common/widgets/shimmers/list_shimmer.dart';
import 'package:fashionapp/const/resource.dart';
import 'package:fashionapp/src/wishlist/controllers/wishlist_notifier.dart';
import 'package:fashionapp/src/wishlist/hooks/fetch_wishlist.dart';
import 'package:fashionapp/src/wishlist/widgets/wishlist_staggered_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
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

    if (products.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              R.ASSETS_ANIMATIONS_LOADING_JSON,
              width: 120.w,
              height: 120.w,
              repeat: true,
            ),
            SizedBox(height: 20.h),
            Text(
              "Danh sách yêu thích trống",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Kolors.kDark,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Hãy thêm sản phẩm yêu thích của bạn để theo dõi",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Kolors.kGray,
              ),
            ),
          ],
        ),
      );
    }

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        // Product count indicator
        Padding(
          padding: EdgeInsets.only(left: 5.w, bottom: 15.h),
          child: Text(
            "${products.length} sản phẩm",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Kolors.kGray,
            ),
          ),
        ),

        // Staggered grid of products
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.h),
          child: StaggeredGrid.count(
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            crossAxisCount: 4,
            children: List.generate(
              products.length,
              (i) {
                final double mainAxisCellCount = (i % 2 == 0 ? 2.17 : 2.4);
                final product = products[i];
                return StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: mainAxisCellCount,
                  child: Hero(
                    tag: 'wishlist_${product.id}',
                    child: WishlistStaggeredTileWidget(
                      onTap: () {
                        if (accessToken == null) {
                          loginBottomSheet(context);
                        } else {
                          context
                              .read<WishlistNotifier>()
                              .addRemoveWishlist(product.id, refetch);
                        }
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
        SizedBox(height: 100.h),
      ],
    );
  }
}
