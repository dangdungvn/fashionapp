import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/src/home/controller/home_tab_notifier.dart';
import 'package:fashionapp/src/home/widgets/categories_list.dart';
import 'package:fashionapp/src/home/widgets/custom_app_bar.dart';
import 'package:fashionapp/src/home/widgets/home_header.dart';
import 'package:fashionapp/src/home/widgets/home_slider.dart';
import 'package:fashionapp/src/home/widgets/home_tabs.dart';
import 'package:fashionapp/src/products/widgets/explore_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: homeTabs.length, vsync: this);
    _tabController.addListener(_handleSelection);
    super.initState();
  }

  void _handleSelection() {
    final controller = Provider.of<HomeTabNotifier>(context, listen: false);
    if (_tabController.indexIsChanging) {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
      controller.setIndex(homeTabs[_currentTabIndex]);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleSelection);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kolors.kOffWhite,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(130),
        child: CustomAppBar(),
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
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(height: 20.h),
            const HomeSlider(), // Banner slider

            SizedBox(height: 25.h),

            // Section divider with refined styling
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              child: const HomeHeader(), // "Categories" header
            ),

            SizedBox(height: 15.h),

            // Categories list with enhanced padding
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: const HomeCategoriesList(),
            ),

            SizedBox(height: 25.h),

            // Tabs with modern styling
            Container(
              margin: EdgeInsets.only(bottom: 10.h),
              decoration: BoxDecoration(
                color: Kolors.kWhite,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Kolors.kDark.withOpacity(0.03),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                child: HomeTabs(tabController: _tabController),
              ),
            ),

            SizedBox(height: 15.h),

            // Product grid with enhanced styling
            const ExploreProducts(),

            SizedBox(height: 100.h), // Bottom padding for navigation
          ],
        ),
      ),
    );
  }
}

List<String> homeTabs = [
  "All",
  "Popular",
  "Unisex",
  "Men",
  "Women",
  "Kids",
];
