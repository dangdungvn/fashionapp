import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/back_button.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/common/widgets/shimmers/list_shimmer.dart';
import 'package:fashionapp/src/categories/controllers/category_notifier.dart';
import 'package:fashionapp/src/categories/hooks/fetch_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends HookWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final results = fetchCategories();
    final categories = results.categories;
    final isLoading = results.isLoading;
    // final error = results.error;
    if (isLoading) {
      return const Scaffold(
        body: ListShimmer(),
      );
    } else {}
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        // backgroundColor: Kolors.kGold,
        centerTitle: true,
        title: ReusableText(
          text: AppText.kCategories,
          style: appStyle(16, Kolors.kPrimary, FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, i) {
          final category = categories[i];
          return ListTile(
            onTap: () {
              context
                  .read<CategoryNotifier>()
                  .setCategory(category.title, category.id);
              context.push('/category');
            },
            leading: CircleAvatar(
              backgroundColor: Kolors.kSecondaryLight,
              radius: 18,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.network(category.imageUrl),
              ),
            ),
            title: ReusableText(
              text: category.title,
              style: appStyle(12, Kolors.kGray, FontWeight.normal),
            ),
            trailing: const Icon(
              MaterialCommunityIcons.chevron_right,
              size: 18,
            ),
          );
        },
      ),
    );
  }
}
