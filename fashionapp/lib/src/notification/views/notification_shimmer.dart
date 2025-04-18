import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/common/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class NotificationShimmer extends StatelessWidget {
  const NotificationShimmer({super.key});

  @override
  Widget build(BuildContext context) {
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
          // Nút đánh dấu tất cả thông báo đã đọc (shimmer effect)
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Shimmer.fromColors(
              baseColor: Kolors.kGrayLight.withOpacity(0.3),
              highlightColor: Kolors.kWhite,
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Kolors.kGrayLight.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  IconlyLight.tick_square,
                  color: Kolors.kPrimary,
                  size: 20.sp,
                ),
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
                  // Header shimmer
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                    child: Shimmer.fromColors(
                      baseColor: Kolors.kGrayLight.withOpacity(0.3),
                      highlightColor: Kolors.kWhite,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 12.h),
                        decoration: BoxDecoration(
                          color: Kolors.kGrayLight.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: Kolors.kWhite,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Container(
                              width: 90.w,
                              height: 16.h,
                              color: Kolors.kWhite,
                            ),
                            const Spacer(),
                            Container(
                              width: 70.w,
                              height: 14.h,
                              color: Kolors.kWhite,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Notification shimmer items
                  Expanded(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 8, // Hiển thị 8 placeholder khi đang tải
                      itemBuilder: (context, index) {
                        return _buildNotificationShimmerItem();
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

  Widget _buildNotificationShimmerItem() {
    return Shimmer.fromColors(
      baseColor: Kolors.kGrayLight.withOpacity(0.3),
      highlightColor: Kolors.kWhite,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Kolors.kGrayLight.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon placeholder
            Container(
              width: 40.w,
              height: 40.w,
              decoration: const BoxDecoration(
                color: Kolors.kWhite,
                shape: BoxShape.circle,
              ),
            ),

            SizedBox(width: 12.w),

            // Content placeholder
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Title placeholder
                      Container(
                        width: 120.w,
                        height: 16.h,
                        color: Kolors.kWhite,
                      ),

                      // Time placeholder
                      Container(
                        width: 60.w,
                        height: 12.h,
                        color: Kolors.kWhite,
                      ),
                    ],
                  ),

                  SizedBox(height: 10.h),

                  // Message placeholder lines
                  Container(
                    width: double.infinity,
                    height: 12.h,
                    color: Kolors.kWhite,
                  ),

                  SizedBox(height: 6.h),

                  Container(
                    width: double.infinity,
                    height: 12.h,
                    color: Kolors.kWhite,
                  ),

                  SizedBox(height: 6.h),

                  Container(
                    width: 200.w,
                    height: 12.h,
                    color: Kolors.kWhite,
                  ),

                  SizedBox(height: 10.h),

                  // // Button placeholder (cho một số thông báo có nút)
                  // index % 3 == 0
                  //     ? Container(
                  //         width: 120.w,
                  //         height: 30.h,
                  //         decoration: BoxDecoration(
                  //           color: Kolors.kWhite,
                  //           borderRadius: BorderRadius.circular(15.r),
                  //         ),
                  //       )
                  //     : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
