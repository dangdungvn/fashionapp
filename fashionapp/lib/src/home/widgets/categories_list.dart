import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/common/widgets/shimmers/categories_shimmer.dart';
import 'package:fashionapp/src/categories/controllers/category_notifier.dart';
import 'package:fashionapp/src/categories/hooks/fetch_home_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeCategoriesList extends HookWidget {
  const HomeCategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final results = fetchHomeCategories();
    final categories = results.categories;
    final isLoading = results.isLoading;

    if (isLoading) {
      return const CatergoriesShimmer();
    }

    return SizedBox(
      height: 100.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        separatorBuilder: (context, index) => SizedBox(width: 15.w),
        itemBuilder: (context, i) {
          final category = categories[i];
          return GestureDetector(
            onTap: () {
              context
                  .read<CategoryNotifier>()
                  .setCategory(category.title, category.id);
              context.push('/category');
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Category icon with modern styling and animation
                Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: _getCategoryColor(i),
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: _getCategoryColor(i).last.withOpacity(0.3),
                        blurRadius: 8,
                        spreadRadius: 1,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(15.h),
                    child: SvgPicture.network(
                      category.imageUrl,
                      placeholderBuilder: (context) => Center(
                        child: SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Kolors.kWhite,
                          ),
                        ),
                      ),
                      colorFilter: const ColorFilter.mode(
                        Kolors.kWhite,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 8.h),

                // Category name with modern text style
                Text(
                  category.title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Kolors.kDark,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Helper method to get different colors for each category
  List<Color> _getCategoryColor(int index) {
    final colors = [
      [Kolors.kPrimary, Kolors.kPrimaryLight],
      [Kolors.kAccent, Kolors.kAccent2],
      [Kolors.kBlue, Kolors.kBlue.withOpacity(0.7)],
      [Kolors.kGreen, Kolors.kGreen.withOpacity(0.7)],
      [Kolors.kRed, Kolors.kRed.withOpacity(0.7)],
    ];

    return colors[index % colors.length];
  }
}
