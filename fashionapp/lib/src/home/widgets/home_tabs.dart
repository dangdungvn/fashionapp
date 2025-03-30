import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/tab_widget.dart';
import 'package:fashionapp/src/home/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTabs extends StatefulWidget {
  const HomeTabs({super.key, required TabController tabController})
      : _tabController = tabController;

  final TabController _tabController;

  @override
  State<HomeTabs> createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Lắng nghe sự thay đổi tab để cập nhật UI
    widget._tabController.addListener(_handleTabSelection);
    _selectedIndex = widget._tabController.index;
  }

  @override
  void dispose() {
    widget._tabController.removeListener(_handleTabSelection);
    super.dispose();
  }

  void _handleTabSelection() {
    if (widget._tabController.indexIsChanging ||
        _selectedIndex != widget._tabController.index) {
      setState(() {
        _selectedIndex = widget._tabController.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
      child: TabBar(
        controller: widget._tabController,
        indicator: const BoxDecoration(), // Ẩn indicator mặc định
        labelPadding: EdgeInsets.symmetric(horizontal: 4.w),
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        dividerColor: Colors.transparent,
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        tabs: List.generate(
          homeTabs.length,
          (index) => Tab(
            child: TabWidget(
              text: homeTabs[index],
              isSelected: _selectedIndex == index,
            ),
          ),
        ),
      ),
    );
  }
}
