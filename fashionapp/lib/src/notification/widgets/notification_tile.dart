import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/src/notification/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get_time_ago/get_time_ago.dart';

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
        decoration: BoxDecoration(
          color: i.isOdd ? Kolors.kOffWhite : Kolors.kWhite,
          border: Border.symmetric(
            horizontal: BorderSide(width: .2.h, color: Kolors.kGrayLight),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const CircleAvatar(
                backgroundColor: Kolors.kWhite,
                child: Icon(Ionicons.notifications,
                    color: Kolors.kPrimary, size: 28),
              ),
              SizedBox(width: 10.w),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  children: [
                    SizedBox(
                      width: ScreenUtil().screenWidth * .82.w,
                      child: Row(
                        children: [
                          ReusableText(
                            text: notification.title,
                            style: appStyle(
                                13, Kolors.kGrayLight, FontWeight.w500),
                          ),
                          const Spacer(),
                          ReusableText(
                            text: GetTimeAgo.parse(notification.createdAt),
                            style: appStyle(
                                12, Kolors.kGrayLight, FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().screenWidth * .82.w,
                      child: Text(
                        notification.message,
                        textAlign: TextAlign.justify,
                        maxLines: 3,
                        style: appStyle(12, Kolors.kGray, FontWeight.normal),
                      ),
                    ),
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
