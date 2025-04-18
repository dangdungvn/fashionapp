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
    // Lấy kích thước màn hình để tính toán chiều cao phù hợp
    final screenHeight = MediaQuery.of(context).size.height;

    return Consumer<ProductNotifier>(
      builder: (context, productNotifier, child) {
        final bool isExpanded = productNotifier.description;

        // Tính toán chiều cao dựa trên tỉ lệ màn hình
        final collapsedHeight = 0.075.sh; // 7.5% chiều cao màn hình
        final expandedHeight =
            screenHeight * 0.4; // 40% chiều cao màn hình, nhưng không quá 400px

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: isExpanded ? expandedHeight : collapsedHeight,
                ),
                child: Text(
                  text,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Kolors.kGray,
                    height: 1.5,
                  ),
                ),
              ),
            ),

            // Hiệu ứng gradient cho text thu gọn
            if (!isExpanded)
              Transform.translate(
                offset: Offset(0, -20.h), // Dịch chuyển lên trên 20.h
                child: Container(
                  height: 20.h,
                  width: double.infinity,
                  // margin: EdgeInsets.only(top: -20.h), // Bỏ dòng margin này đi
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0.1),
                        Colors.white,
                      ],
                    ),
                  ),
                ),
              ),

            // Nút chuyển đổi
            GestureDetector(
              onTap: () {
                productNotifier.setDescription();
              },
              child: Container(
                margin: EdgeInsets.only(top: 10.h),
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Kolors.kPrimaryLight.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
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
          ],
        );
      },
    );
  }
}
