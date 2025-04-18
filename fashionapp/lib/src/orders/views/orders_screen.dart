import 'package:fashionapp/common/utils/enums.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/common/widgets/back_button.dart';
import 'package:fashionapp/const/resource.dart';
import 'package:fashionapp/src/orders/widgets/order_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class OrdersPage extends StatefulHookWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Kolors.kOffWhite,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          leading: const AppBackButton(),
          centerTitle: true,
          title: Text(
            AppText.kOrders,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Kolors.kPrimary,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60.h),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                  color: Kolors.kWhite,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Kolors.kDark.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: Kolors.kPrimary,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Kolors.kPrimary.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    dividerColor: Colors.transparent,
                    labelColor: Kolors.kWhite,
                    unselectedLabelColor: Kolors.kGray,
                    labelStyle: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    unselectedLabelStyle: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    indicatorPadding: EdgeInsets.symmetric(horizontal: -18.w),
                    tabs: const [
                      Tab(text: 'Processing'),
                      Tab(text: 'Completed'),
                      Tab(text: 'Cancelled'),
                    ],
                  ),
                ),
              ),
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
                Kolors.kSecondaryLight.withOpacity(0.2),
              ],
            ),
          ),
          child: Stack(
            children: [
              // Decorative elements
              Positioned(
                top: -50,
                right: -30,
                child: Container(
                  width: 150.w,
                  height: 150.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Kolors.kPrimary.withOpacity(0.03),
                  ),
                ),
              ),
              Positioned(
                bottom: 100,
                left: -50,
                child: Container(
                  width: 180.w,
                  height: 180.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Kolors.kPrimaryLight.withOpacity(0.05),
                  ),
                ),
              ),

              // Header with animation and title
              Positioned(
                top: 100.h,
                left: 20.w,
                right: 20.w,
                child: Row(
                  children: [
                    Lottie.asset(
                      R.ASSETS_ANIMATIONS_LOADING_JSON,
                      width: 40.w,
                      height: 40.w,
                      repeat: true,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Lịch sử đơn hàng",
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Kolors.kDark,
                            ),
                          ),
                          Text(
                            "Theo dõi và quản lý đơn hàng của bạn",
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              color: Kolors.kGray,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Tab content
              Padding(
                padding: EdgeInsets.only(top: 160.h),
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    OrderWidget(ordersTypes: FetchOrdersTypes.pending),
                    OrderWidget(ordersTypes: FetchOrdersTypes.delivered),
                    OrderWidget(ordersTypes: FetchOrdersTypes.cancelled),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
