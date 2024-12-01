import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/back_button.dart';
import 'package:fashionapp/common/widgets/empty_screen_widget.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/src/notification/controllers/notification_notifier.dart';
import 'package:fashionapp/src/notification/hooks/fetch_notifications.dart';
import 'package:fashionapp/src/notification/views/notification_shimmer.dart';
import 'package:fashionapp/src/notification/widgets/notification_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class NotificationsPage extends HookWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final result = fetchNotifications(context);
    final notifications = result.notifications;
    final isLoading = result.isLoading;
    if (isLoading) {
      return const NotificationShimmer();
    }
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        centerTitle: true,
        title: ReusableText(
          text: AppText.kNotifications,
          style: appStyle(16, Kolors.kPrimary, FontWeight.w600),
        ),
      ),
      body: notifications.isEmpty
          ? const EmptyScreenWidget()
          : ListView(
              children: List.generate(
                notifications.length,
                (index) {
                  return NotificationTile(
                    notification: notifications[index],
                    i: index,
                    onUpdate: () {
                      context.read<NotificationNotifier>().setOrderId(
                            notifications[index].orderId,
                          );
                      context.push('/tracking');
                    },
                  );
                },
              ),
            ),
    );
  }
}
