import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/login_bottom_sheet.dart';
import 'package:fashionapp/src/notification/hooks/fetch_count.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';

class NotificationWidget extends HookWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final result = fetchCount(context);
    final data = result.count;
    final isLoading = result.isLoading;
    return GestureDetector(
      onTap: () {
        if (Storage().getString('accessToken') == null) {
          loginBottomSheet(context);
          // context.push("/login");
        } else {
          context.push("/notifications");
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: CircleAvatar(
          backgroundColor: Kolors.kGrayLight.withOpacity(.3),
          child: Badge(
            label: Text(isLoading ? '...' : data.unreadCount.toString()),
            child: const Icon(Ionicons.notifications, color: Kolors.kPrimary),
          ),
        ),
      ),
    );
  }
}
