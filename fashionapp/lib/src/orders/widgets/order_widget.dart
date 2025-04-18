import 'package:fashionapp/common/utils/enums.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/const/resource.dart';
import 'package:fashionapp/src/notification/views/notification_shimmer.dart';
import 'package:fashionapp/src/orders/hooks/fetch_orders.dart';
import 'package:fashionapp/src/orders/widgets/order_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class OrderWidget extends HookWidget {
  const OrderWidget({
    super.key,
    required this.ordersTypes,
  });

  final FetchOrdersTypes ordersTypes;

  @override
  Widget build(BuildContext context) {
    final results = fetchOrders(ordersTypes);
    final orders = results.orders;
    final isLoading = results.isLoading;

    if (isLoading) {
      return const NotificationShimmer();
    }

    if (orders.isEmpty) {
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
              "Không có đơn hàng nào",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Kolors.kDark,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Bạn chưa có đơn hàng nào trong mục này",
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

    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.h),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        physics: const BouncingScrollPhysics(),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Order information header
                Container(
                  margin: EdgeInsets.only(bottom: 5.h),
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Order number
                      Text(
                        "Đơn hàng #${orders[index].id}",
                        style: GoogleFonts.poppins(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: Kolors.kDark,
                        ),
                      ),

                      // Order date
                      Text(
                        "Ngày đặt: ${orders[index].createdAt.toIso8601String().split('T')[0]}",
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          color: Kolors.kGray,
                        ),
                      ),
                    ],
                  ),
                ),

                // Status indicator
                Container(
                  margin: EdgeInsets.only(bottom: 8.h, left: 5.w),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(orders[index].deliveryStatus)
                              .withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _getStatusText(orders[index].deliveryStatus),
                          style: GoogleFonts.poppins(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                            color:
                                _getStatusColor(orders[index].deliveryStatus),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: Kolors.kPrimaryLight.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "Total: \$${orders[index].total.toStringAsFixed(2)}",
                          style: GoogleFonts.poppins(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                            color: Kolors.kPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Order items
                OrderTile(order: orders[index]),
              ],
            ),
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Kolors.kGray;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'pending':
        return 'Đang xử lý';
      case 'delivered':
        return 'Đã giao hàng';
      case 'cancelled':
        return 'Đã hủy';
      default:
        return status;
    }
  }
}
