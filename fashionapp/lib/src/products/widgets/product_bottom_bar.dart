import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ProductBottomBar extends StatelessWidget {
  const ProductBottomBar({super.key, required this.price, this.onPressed});
  final String price;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    // Lấy thông tin về màn hình để điều chỉnh kích thước
    final mediaQuery = MediaQuery.of(context);
    final bottomPadding = mediaQuery.padding.bottom;

    return SafeArea(
      child: Container(
        // Chiều cao tự động điều chỉnh theo kích thước màn hình
        height: (80.0.h).clamp(70.0, 90.0),
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          bottom: bottomPadding > 0
              ? 5.h
              : 10.h, // Điều chỉnh padding dựa trên inset
          top: 5.h,
        ),
        decoration: BoxDecoration(
          color: Kolors.kWhite,
          boxShadow: [
            BoxShadow(
              color: Kolors.kDark.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Phần giá sản phẩm
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Kolors.kPrimaryLight.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Price',
                    style: TextStyle(
                      fontSize: 12,
                      color: Kolors.kGray,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "\$$price",
                    style: TextStyle(
                      fontSize:
                          18.sp.clamp(16.0, 20.0), // Đảm bảo font size phù hợp
                      fontWeight: FontWeight.bold,
                      color: Kolors.kPrimary,
                    ),
                  ),
                ],
              ),
            ),

            // Nút thêm vào giỏ hàng
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 15.w),
                height: 50.h.clamp(45.0, 60.0), // Chiều cao có giới hạn min-max
                child: ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Kolors.kPrimary,
                    foregroundColor: Kolors.kWhite,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    shadowColor: Kolors.kPrimary.withOpacity(0.3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(6.sp.clamp(4.0, 8.0)),
                        decoration: BoxDecoration(
                          color: Kolors.kWhite.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          FontAwesome.shopping_bag,
                          size: 14.sp.clamp(12.0, 16.0),
                          color: Kolors.kWhite,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        "Add to Cart",
                        style: TextStyle(
                          fontSize: 16
                              .sp
                              .clamp(14.0, 18.0), // Đảm bảo font size phù hợp
                          fontWeight: FontWeight.w600,
                          color: Kolors.kWhite,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
