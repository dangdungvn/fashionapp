import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/src/notification/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:iconly/iconly.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    required this.notification,
    this.onUpdate,
    required this.i,
  });
  final NotificationModel notification;
  final void Function()? onUpdate;
  final int i;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onUpdate,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon thông báo với màu sắc dựa trên loại thông báo
              _buildNotificationIcon(),

              SizedBox(width: 12.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header với tiêu đề và thời gian
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Kolors.kDark,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          GetTimeAgo.parse(notification.createdAt),
                          style: GoogleFonts.poppins(
                            fontSize: 11.sp,
                            color: Kolors.kGrayLight,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 6.h),

                    // Nội dung thông báo
                    Text(
                      notification.message,
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        color: Kolors.kGray,
                        height: 1.4,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: 10.h),

                    // Nút tương tác (nếu cần)
                    _buildActionButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Icon thông báo với hiệu ứng đẹp
  Widget _buildNotificationIcon() {
    // Xác định màu sắc dựa vào loại thông báo
    Color iconColor = Kolors.kPrimary;
    Color bgColor = Kolors.kPrimaryLight.withOpacity(0.1);
    IconData iconData = IconlyBold.notification;

    // Adjust color based on notification type or content
    if (notification.title.toLowerCase().contains("đặt hàng") ||
        notification.title.toLowerCase().contains("order")) {
      iconColor = Kolors.kGreen;
      bgColor = Kolors.kGreen.withOpacity(0.1);
      iconData = IconlyBold.bag;
    } else if (notification.title.toLowerCase().contains("khuyến mãi") ||
        notification.title.toLowerCase().contains("giảm giá") ||
        notification.title.toLowerCase().contains("sale")) {
      iconColor = Kolors.kGold;
      bgColor = Kolors.kGold.withOpacity(0.1);
      iconData = IconlyBold.discount;
    } else if (notification.title.toLowerCase().contains("lỗi") ||
        notification.title.toLowerCase().contains("hủy") ||
        notification.title.toLowerCase().contains("error") ||
        notification.title.toLowerCase().contains("cancel")) {
      iconColor = Kolors.kRed;
      bgColor = Kolors.kRed.withOpacity(0.1);
      iconData = IconlyBold.danger;
    }

    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        iconData,
        color: iconColor,
        size: 22.sp,
      ),
    );
  }

  // Nút hành động (nếu thông báo có liên quan đến đơn hàng)
  Widget _buildActionButton() {
    return GestureDetector(
      onTap: onUpdate,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Kolors.kPrimaryLight.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              IconlyLight.location,
              color: Kolors.kPrimary,
              size: 14.sp,
            ),
            SizedBox(width: 6.w),
            Text(
              "Xem chi tiết",
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Kolors.kPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
