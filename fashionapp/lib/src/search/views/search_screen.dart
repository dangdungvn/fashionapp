import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/common/widgets/back_button.dart';
import 'package:fashionapp/common/widgets/empty_screen_widget.dart';
import 'package:fashionapp/common/widgets/login_bottom_sheet.dart';
import 'package:fashionapp/src/products/widgets/staggered_tile_widget.dart';
import 'package:fashionapp/src/search/controllers/search_notifier.dart';
import 'package:fashionapp/src/wishlist/controllers/wishlist_notifier.dart';
import 'package:fashionapp/src/wishlist/hooks/fetch_wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulHookWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_searchController.text.isNotEmpty) {
      context.read<SearchNotifier>().searchFunction(_searchController.text);
    } else {
      context.read<SearchNotifier>().clearResults();
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    final resultsWishlist = fetchWishlist();
    final wishlistProduct = resultsWishlist.products;
    final isLoadingWishlist = resultsWishlist.isLoading;
    final refetchWishlist = resultsWishlist.refetch;

    return Scaffold(
      backgroundColor: Kolors.kOffWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Kolors.kOffWhite,
        centerTitle: true,
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
            child: AppBackButton(
              onTap: () {
                context.read<SearchNotifier>().clearResults();
                context.pop();
              },
            ),
          ),
        ),
        title: const Text(
          AppText.kSearch,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Kolors.kDark,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Kolors.kOffWhite,
              Kolors.kWhite,
              Kolors.kSecondaryLight.withOpacity(0.3),
            ],
          ),
        ),
        child: Column(
          children: [
            // Thanh tìm kiếm với thiết kế mới
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              decoration: BoxDecoration(
                color: Kolors.kWhite,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Kolors.kDark.withOpacity(0.05),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(
                  fontSize: 14,
                  color: Kolors.kDark,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: AppText.kSearchHint,
                  hintStyle: const TextStyle(
                    color: Kolors.kGray,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: const Icon(
                      IconlyLight.search,
                      color: Kolors.kPrimary,
                      size: 20,
                    ),
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Kolors.kGray,
                            size: 20,
                          ),
                          onPressed: () {
                            _searchController.clear();
                            context.read<SearchNotifier>().clearResults();
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                    vertical: 15.h,
                  ),
                ),
                onSubmitted: (_) {
                  if (_searchController.text.isNotEmpty) {
                    context
                        .read<SearchNotifier>()
                        .searchFunction(_searchController.text);
                  }
                },
              ),
            ),

            // Kết quả tìm kiếm
            Expanded(
              child: Consumer<SearchNotifier>(
                builder: (context, searchNotifier, child) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        // Hiển thị nhãn kết quả nếu có
                        searchNotifier.results.isNotEmpty
                            ? Container(
                                margin: EdgeInsets.only(bottom: 15.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      AppText.kSearchResults,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Kolors.kDark,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                        vertical: 5.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Kolors.kPrimaryLight
                                            .withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        '"${searchNotifier.searchKey}"',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Kolors.kPrimary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),

                        // Lưới sản phẩm với thiết kế hiện đại
                        searchNotifier.results.isNotEmpty
                            ? StaggeredGrid.count(
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 15,
                                crossAxisCount: 4,
                                children: List.generate(
                                  searchNotifier.results.length,
                                  (i) {
                                    final double mainAxisCellCount =
                                        (i % 2 == 0 ? 2.17 : 2.4);
                                    final product = searchNotifier.results[i];
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
                                                .addRemoveWishlist(
                                                    product.id, () {});
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
                              )
                            : const Padding(
                                padding: EdgeInsets.symmetric(vertical: 50),
                                child: EmptyScreenWidget(),
                              )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
