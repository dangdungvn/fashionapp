import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/back_button.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/src/notification/controllers/notification_notifier.dart';
import 'package:fashionapp/src/notification/views/notification_shimmer.dart';
import 'package:fashionapp/src/notification/widgets/notification_order_tile.dart';
import 'package:fashionapp/src/orders/hooks/fetch_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TrackOrderPage extends HookWidget {
  const TrackOrderPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final results = fetchOrder(context.read<NotificationNotifier>().orderId);

    final isLoading = results.isLoading;
    final order = results.order;

    if (isLoading) {
      return const NotificationShimmer();
    }

    return Scaffold(
      backgroundColor: Kolors.kOffWhite,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: const AppBackButton(),
        title: Text(
          AppText.kTrack,
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
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
                  color: Kolors.kPrimary.withOpacity(0.05),
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

            // Main content
            SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Order details card
                    NotificationOrderTile(order: order!),

                    SizedBox(height: 25.h),

                    // Delivery progress section
                    Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: Kolors.kWhite,
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: Kolors.kDark.withOpacity(0.03),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Trạng thái đơn hàng",
                                style: GoogleFonts.poppins(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Kolors.kDark,
                                ),
                              ),

                              // Status badge
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 6.h),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(order.deliveryStatus)
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      _getStatusIcon(order.deliveryStatus),
                                      size: 14.sp,
                                      color:
                                          _getStatusColor(order.deliveryStatus),
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      order.deliveryStatus.toUpperCase(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: _getStatusColor(
                                            order.deliveryStatus),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 20.h),

                          // Delivery timeline
                          _buildTrackingTimeline(order.deliveryStatus),

                          SizedBox(height: 10.h),

                          // Expected delivery date
                          Container(
                            margin: EdgeInsets.only(top: 10.h),
                            padding: EdgeInsets.all(15.w),
                            decoration: BoxDecoration(
                              color: Kolors.kPrimaryLight.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: Kolors.kPrimaryLight.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  IconlyBold.calendar,
                                  color: Kolors.kPrimary,
                                  size: 20.sp,
                                ),
                                SizedBox(width: 10.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Dự kiến giao hàng",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12.sp,
                                        color: Kolors.kGray,
                                      ),
                                    ),
                                    SizedBox(height: 3.h),
                                    Text(
                                      _formatDate(order.createdAt
                                          .add(const Duration(days: 3))),
                                      style: GoogleFonts.poppins(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Kolors.kDark,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 25.h),

                    // Order details section
                    Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: Kolors.kWhite,
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: Kolors.kDark.withOpacity(0.03),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Chi tiết đơn hàng",
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Kolors.kDark,
                            ),
                          ),

                          SizedBox(height: 15.h),

                          // Order info items
                          _buildOrderInfoItem(
                            "Mã theo dõi",
                            order.id.toString().substring(0, 2) + "...",
                            IconlyBold.document,
                          ),

                          _buildOrderInfoItem(
                            "Trạng thái thanh toán",
                            order.paymentStatus.toUpperCase(),
                            IconlyBold.wallet,
                            color: order.paymentStatus.toLowerCase() == "paid"
                                ? Kolors.kGreen
                                : Kolors.kGold,
                          ),

                          _buildOrderInfoItem(
                            "Phí vận chuyển",
                            "\$ 10.00",
                            IconlyBold.location,
                          ),

                          _buildOrderInfoItem(
                            "Ngày đặt hàng",
                            _formatDate(order.createdAt),
                            IconlyBold.time_circle,
                            isLast: true,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 25.h),

                    // Contact driver button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Implement contact driver functionality
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Kolors.kPrimary,
                          foregroundColor: Kolors.kWhite,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          elevation: 2,
                          shadowColor: Kolors.kPrimary.withOpacity(0.3),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              IconlyBold.call,
                              size: 20.sp,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              "Liên hệ với người giao hàng",
                              style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderInfoItem(String label, String value, IconData icon,
      {Color? color, bool isLast = false}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: (color ?? Kolors.kPrimary).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  icon,
                  size: 20.sp,
                  color: color ?? Kolors.kPrimary,
                ),
              ),
              SizedBox(width: 15.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      color: Kolors.kGray,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    value,
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Kolors.kDark,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (!isLast)
          Divider(
            color: Kolors.kGrayLight.withOpacity(0.3),
            thickness: 1,
          ),
      ],
    );
  }

  Widget _buildTrackingTimeline(String currentStatus) {
    // Get the current status index
    int currentStatusIndex = _getStatusIndex(currentStatus);

    return Column(
      children: [
        for (int i = 0; i < trackingData.length; i++)
          TimelineTile(
            alignment: TimelineAlign.manual,
            lineXY: 0.2,
            isFirst: i == 0,
            isLast: i == trackingData.length - 1,
            indicatorStyle: IndicatorStyle(
              width: 25,
              height: 25,
              indicator: Container(
                decoration: BoxDecoration(
                  color: i <= currentStatusIndex
                      ? Kolors.kPrimary
                      : Kolors.kGrayLight.withOpacity(0.3),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: i <= currentStatusIndex
                        ? Kolors.kPrimary
                        : Kolors.kGrayLight,
                    width: 2,
                  ),
                ),
                child: Icon(
                  i <= currentStatusIndex ? Icons.check : null,
                  size: 14.sp,
                  color: Kolors.kWhite,
                ),
              ),
            ),
            beforeLineStyle: LineStyle(
              color: i <= currentStatusIndex
                  ? Kolors.kPrimary
                  : Kolors.kGrayLight.withOpacity(0.3),
              thickness: 2,
            ),
            afterLineStyle: LineStyle(
              color: i < currentStatusIndex
                  ? Kolors.kPrimary
                  : Kolors.kGrayLight.withOpacity(0.3),
              thickness: 2,
            ),
            endChild: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trackingData[i].status,
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: i <= currentStatusIndex
                          ? FontWeight.w600
                          : FontWeight.normal,
                      color:
                          i <= currentStatusIndex ? Kolors.kDark : Kolors.kGray,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    i <= currentStatusIndex
                        ? trackingData[i].date
                        : "Đang chờ xử lý",
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      color: i <= currentStatusIndex
                          ? Kolors.kPrimary
                          : Kolors.kGrayLight,
                    ),
                  ),
                ],
              ),
            ),
            startChild: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
              child: Icon(
                trackingData[i].icon,
                size: 24.sp,
                color: i <= currentStatusIndex
                    ? Kolors.kPrimary
                    : Kolors.kGrayLight,
              ),
            ),
          ),
      ],
    );
  }

  int _getStatusIndex(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 0;
      case 'processing':
        return 1;
      case 'on delivery':
      case 'in transit':
        return 2;
      case 'delivered':
        return 3;
      default:
        return 0;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Kolors.kGold;
      case 'processing':
        return Kolors.kBlue;
      case 'on delivery':
      case 'in transit':
        return Kolors.kPrimaryLight;
      case 'delivered':
        return Kolors.kGreen;
      case 'cancelled':
        return Kolors.kRed;
      default:
        return Kolors.kPrimary;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return IconlyBold.time_circle;
      case 'processing':
        return IconlyBold.activity;
      case 'on delivery':
      case 'in transit':
        return IconlyBold.location;
      case 'delivered':
        return IconlyBold.tick_square;
      case 'cancelled':
        return IconlyBold.close_square;
      default:
        return IconlyBold.document;
    }
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}

List<TrackData> trackingData = [
  TrackData(
    icon: Ionicons.clipboard_outline,
    date: "07/04/2024",
    status: "Đơn hàng đã đặt",
    address: "1234, Elm St, Springfield",
  ),
  TrackData(
    icon: Feather.package,
    date: "08/04/2024",
    status: "Đang xử lý",
    address: "Processing Center, Springfield",
  ),
  TrackData(
    icon: MaterialCommunityIcons.truck_check_outline,
    date: "09/04/2024",
    status: "Đang vận chuyển",
    address: "On the way, Springfield",
  ),
  TrackData(
    icon: Ionicons.checkbox_outline,
    date: "10/04/2024",
    status: "Đã giao hàng",
    address: "1234, Elm St, Springfield",
  ),
];

class TrackData {
  final String date;
  final String status;
  final String address;
  final IconData icon;

  TrackData(
      {required this.date,
      required this.status,
      required this.address,
      required this.icon});
}
