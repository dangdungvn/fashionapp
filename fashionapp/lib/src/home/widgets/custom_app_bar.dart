import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/shimmers/shimmer_widget.dart';
import 'package:fashionapp/src/addresses/hooks/fetch_defaults.dart';
import 'package:fashionapp/src/home/widgets/notification_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';

class CustomAppBar extends HookWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final result = fetchDefaultAddress();
    final address = result.address;
    final isLoading = result.isLoading;

    return AppBar(
      elevation: 0,
      backgroundColor: Kolors.kOffWhite,
      automaticallyImplyLeading: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 3),
            child: Text(
              "Location",
              style: TextStyle(
                fontSize: 13,
                color: Kolors.kGray,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 5.h),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Kolors.kPrimary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  IconlyLight.location,
                  size: 14,
                  color: Kolors.kPrimary,
                ),
              ),
              SizedBox(width: 5.w),
              isLoading
                  ? const ShimmerWidget(
                      shimmerHieght: 20,
                      shimmerWidth: 100,
                      shimmerRadius: 12,
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: SizedBox(
                        width: ScreenUtil().screenWidth * 0.65,
                        child: Text(
                          address == null
                              ? "Please select your location"
                              : address.address,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Kolors.kDark,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
            ],
          )
        ],
      ),
      actions: const [
        NotificationWidget(),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: Row(
            children: [
              // Search bar with modern styling
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    context.push("/search");
                  },
                  child: Container(
                    height: 45.h,
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    decoration: BoxDecoration(
                      color: Kolors.kWhite,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Kolors.kDark.withOpacity(0.05),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          IconlyLight.search,
                          size: 20,
                          color: Kolors.kPrimary,
                        ),
                        SizedBox(width: 12.w),
                        const Text(
                          "Search products",
                          style: TextStyle(
                            fontSize: 14,
                            color: Kolors.kGray,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(width: 10.w),

              // Filter button with modernized style
              GestureDetector(
                onTap: () {
                  // TODO: Implement filter functionality
                },
                child: Container(
                  height: 45.h,
                  width: 45.w,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Kolors.kPrimary,
                        Kolors.kPrimaryLight,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Kolors.kPrimary.withOpacity(0.25),
                        blurRadius: 8,
                        spreadRadius: 1,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    IconlyLight.filter,
                    color: Kolors.kWhite,
                    size: 20,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
