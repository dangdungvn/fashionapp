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
      backgroundColor: Kolors.kWhite,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Kolors.kWhite,
        leading: const AppBackButton(),
        title: ReusableText(
            text: AppText.kTrack,
            style: appStyle(14, Kolors.kPrimary, FontWeight.w600)),
      ),
      body: Container(
          color: Kolors.kWhite,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: ListView(
              children: [
                NotificationOrderTile(order: order!),
                SizedBox(
                  height: 20.h,
                ),
                Divider(
                  thickness: 0.5.h,
                ),
                SizedBox(
                  height: 10.h,
                ),
                ReusableText(
                    text: "Order Details",
                    style: appStyle(13, Kolors.kDark, FontWeight.w600)),
                SizedBox(
                  height: 20.h,
                ),
                Table(
                  border: TableBorder.all(
                    color: Kolors.kGrayLight,
                    style: BorderStyle.solid,
                    width: 0.5,
                  ),
                  children: [
                    TableRow(
                      // Define the first row of the table
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Text(
                            'Logistics',
                            style:
                                appStyle(12, Kolors.kGray, FontWeight.normal),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(8.h),
                            child: Text(
                              "\$ 10.00",
                              style:
                                  appStyle(12, Kolors.kDark, FontWeight.normal),
                            )),
                      ],
                    ),
                    TableRow(
                      // Define the second row of the table
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Text(
                            'Tracking code',
                            style:
                                appStyle(12, Kolors.kGray, FontWeight.normal),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Text(
                            order.id.toString(),
                            style:
                                appStyle(12, Kolors.kDark, FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      // Define the second row of the table
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Text(
                            'Payment Status',
                            style:
                                appStyle(12, Kolors.kGray, FontWeight.normal),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Text(
                            order.paymentStatus.toUpperCase(),
                            style:
                                appStyle(12, Kolors.kDark, FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      // Define the second row of the table
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Text(
                            'Delivery Status',
                            style:
                                appStyle(12, Kolors.kGray, FontWeight.normal),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Text(
                            order.deliveryStatus.toUpperCase(),
                            style:
                                appStyle(12, Kolors.kDark, FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      // Define the second row of the table
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Text(
                            'Expected Delivery Date',
                            style:
                                appStyle(12, Kolors.kGray, FontWeight.normal),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Text(
                            order.createdAt
                                .add(const Duration(days: 3))
                                .toString()
                                .substring(0, 10),
                            style:
                                appStyle(12, Kolors.kDark, FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

class SteppersTile extends StatelessWidget {
  const SteppersTile({
    super.key,
    required this.status,
    required this.date,
    required this.address,
    required this.color,
    required this.icon,
    required this.isLast,
  });

  final String status, date, address;
  final Color color;
  final IconData icon;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Column(
              children: [
                isLast == true
                    ? SizedBox.fromSize()
                    : const Icon(
                        AntDesign.checkcircle,
                        size: 18,
                        color: Kolors.kPrimary,
                      ),
                isLast == true
                    ? SizedBox.fromSize()
                    : Center(
                        child: Container(
                          height: 35,
                          width: 2,
                          color: Kolors.kPrimary,
                        ),
                      ),
                isLast == true
                    ? const Icon(
                        AntDesign.checkcircle,
                        size: 18,
                        color: Kolors.kPrimary,
                      )
                    : SizedBox.fromSize(),
              ],
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: SizedBox(
              width: ScreenUtil().screenWidth * 0.85,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ReusableText(
                          text: status,
                          style: appStyle(12, Kolors.kDark, FontWeight.w500)),
                      ReusableText(
                          text: date,
                          style: appStyle(10, Kolors.kGray, FontWeight.normal)),
                      ReusableText(
                          text: address,
                          style: appStyle(10, Kolors.kGray, FontWeight.normal))
                    ],
                  ),
                  const Spacer(),
                  Icon(
                    icon,
                    color: Kolors.kPrimary.withOpacity(0.4),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

List<TrackData> trackingData = [
  TrackData(
    icon: Ionicons.clipboard_outline,
    date: "2024-04-07",
    status: "Order Placed",
    address: "1234, Elm St, Springfield",
  ),
  TrackData(
    icon: Feather.package,
    date: "2024-04-08",
    status: "Processing",
    address: "Processing Center, Springfield",
  ),
  TrackData(
    icon: MaterialCommunityIcons.truck_check_outline,
    date: "2024-04-09",
    status: "In Transit",
    address: "On the way, Springfield",
  ),
  TrackData(
    icon: Ionicons.checkbox_outline,
    date: "2024-04-10",
    status: "Delivered",
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
