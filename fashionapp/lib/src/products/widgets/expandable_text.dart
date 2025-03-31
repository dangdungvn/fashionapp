import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/src/products/controller/product_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ExpandableText extends StatelessWidget {
  const ExpandableText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductNotifier>(
      builder: (context, productNotifier, child) {
        final bool isExpanded = productNotifier.description;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: isExpanded ? null : 100.h,
                  constraints: BoxConstraints(
                    maxHeight: isExpanded ? 400.h : 100.h,
                  ),
                  child: Text(
                    text,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Kolors.kGray,
                      height: 1.5,
                    ),
                  ),
                ),
                if (!isExpanded)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 40.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white.withOpacity(0.0),
                            Colors.white.withOpacity(1.0),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            // Nút chuyển đổi
            Center(
              child: GestureDetector(
                onTap: () {
                  productNotifier.setDescription();
                },
                child: Container(
                  margin: EdgeInsets.only(top: 8.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: Kolors.kPrimaryLight.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isExpanded ? "Thu gọn" : "Xem thêm",
                        style: TextStyle(
                          color: Kolors.kPrimary,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        size: 16.sp,
                        color: Kolors.kPrimary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
