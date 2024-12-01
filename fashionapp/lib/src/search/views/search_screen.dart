import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/back_button.dart';
import 'package:fashionapp/common/widgets/email_textfield.dart';
import 'package:fashionapp/common/widgets/empty_screen_widget.dart';
import 'package:fashionapp/common/widgets/login_bottom_sheet.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/src/products/widgets/staggered_tile_widget.dart';
import 'package:fashionapp/src/search/controllers/search_notifier.dart';
import 'package:fashionapp/src/wishlist/controllers/wishlist_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // Thêm listener để lắng nghe sự thay đổi text
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    // Chỉ tìm kiếm khi có text, nếu không thì clear kết quả
    if (_searchController.text.isNotEmpty) {
      context.read<SearchNotifier>().searchFunction(_searchController.text);
    } else {
      // Clear kết quả tìm kiếm khi không có text
      context.read<SearchNotifier>().clearResults();
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }
  // void _performSearch() {
  //   if (_searchController.text.isNotEmpty) {
  //     context.read<SearchNotifier>().searchFunction(_searchController.text);
  //   } else {
  //     // print('Search key is empty');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: AppBackButton(
          onTap: () {
            context.read<SearchNotifier>().clearResults();
            context.pop();
          },
        ),
        title: ReusableText(
          text: AppText.kSearch,
          style: appStyle(15, Kolors.kPrimary, FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: Padding(
            padding: EdgeInsets.all(14.w),
            child: EmailTextField(
              controller: _searchController,
              radius: 30,
              // onSubmitted: (_) => _performSearch(),
              hintText: AppText.kSearchHint,
              prefixIcon: GestureDetector(
                onTap: () {
                  if (_searchController.text.isNotEmpty) {
                    context
                        .read<SearchNotifier>()
                        .searchFunction(_searchController.text);
                  } else {
                    // print('Search key is empty');
                  }
                },
                child: const Icon(
                  AntDesign.search1,
                  color: Kolors.kPrimary,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Consumer<SearchNotifier>(
        builder: (context, searchNotifier, child) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: ListView(
              children: [
                searchNotifier.results.isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(
                            text: AppText.kSearchResults,
                            style:
                                appStyle(13, Kolors.kPrimary, FontWeight.w600),
                          ),
                          ReusableText(
                            text: searchNotifier.searchKey,
                            style:
                                appStyle(13, Kolors.kPrimary, FontWeight.w600),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                SizedBox(
                  height: 10.h,
                ),
                searchNotifier.results.isNotEmpty
                    ? StaggeredGrid.count(
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
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
                                        .addRemoveWishlist(product.id, () {});
                                  }
                                },
                                i: i,
                                product: product,
                              ),
                            );
                          },
                        ),
                      )
                    : const EmptyScreenWidget()
              ],
            ),
          );
        },
      ),
    );
  }
}
