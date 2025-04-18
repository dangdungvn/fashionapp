import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/common/widgets/back_button.dart';
import 'package:fashionapp/const/resource.dart';
import 'package:fashionapp/src/notification/controllers/notification_notifier.dart';
import 'package:fashionapp/src/notification/hooks/fetch_notifications.dart';
import 'package:fashionapp/src/notification/views/notification_shimmer.dart';
import 'package:fashionapp/src/notification/widgets/notification_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

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
      backgroundColor: Kolors.kOffWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        leading: const AppBackButton(),
        centerTitle: true,
        title: Text(
          AppText.kNotifications,
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            color: Kolors.kDark,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          // Nút đánh dấu tất cả thông báo đã đọc
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Kolors.kPrimaryLight.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                IconlyLight.tick_square,
                color: Kolors.kPrimary,
                size: 20.sp,
              ),
            ),
          ),
        ],
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
        child: notifications.isEmpty
            ? _buildEmptyState()
            : Stack(
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
                    bottom: 50,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header with notification count
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 16.h),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 12.h),
                            decoration: BoxDecoration(
                              color: Kolors.kWhite,
                              borderRadius: BorderRadius.circular(16.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Kolors.kDark.withOpacity(0.03),
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.w),
                                  decoration: BoxDecoration(
                                    color:
                                        Kolors.kPrimaryLight.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    IconlyBold.notification,
                                    color: Kolors.kPrimary,
                                    size: 18.sp,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Text(
                                  "${notifications.length} thông báo",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Kolors.kDark,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  "Tất cả tin nhắn",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Kolors.kPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Notification list
                        Expanded(
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: notifications.length,
                            itemBuilder: (context, index) {
                              return NotificationTile(
                                notification: notifications[index],
                                i: index,
                                onUpdate: () {
                                  context
                                      .read<NotificationNotifier>()
                                      .setOrderId(
                                        notifications[index].orderId,
                                      );
                                  context.push('/tracking');
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            R.ASSETS_ANIMATIONS_LOADING_JSON,
            height: 180.h,
            repeat: true,
          ),
          SizedBox(height: 20.h),
          Text(
            "Không có thông báo",
            style: GoogleFonts.poppins(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Kolors.kDark,
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Text(
              "Bạn chưa có thông báo nào. Chúng tôi sẽ thông báo khi có tin mới.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: Kolors.kGray,
              ),
            ),
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}
