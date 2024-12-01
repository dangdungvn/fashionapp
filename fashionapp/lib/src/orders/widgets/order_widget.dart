import 'package:fashionapp/common/utils/enums.dart';
import 'package:fashionapp/common/widgets/empty_screen_widget.dart';
import 'package:fashionapp/src/notification/views/notification_shimmer.dart';
import 'package:fashionapp/src/orders/hooks/fetch_orders.dart';
import 'package:fashionapp/src/orders/widgets/order_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return orders.isEmpty
        ? const EmptyScreenWidget()
        : Container(
            margin: EdgeInsets.symmetric(vertical: 12.h),
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              children: List.generate(orders.length, (i) {
                return OrderTile(order: orders[i]);
              }),
            ),
          );
  }
}
