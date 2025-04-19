import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/src/products/controller/colors_sizes_notifier.dart';
import 'package:fashionapp/src/products/controller/product_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductSizesWidget extends StatelessWidget {
  const ProductSizesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Tính toán kích thước item dựa trên chiều rộng màn hình
    // final screenWidth = MediaQuery.of(context).size.width;
    // Đảm bảo kích thước nút size không quá nhỏ hoặc quá lớn
    final sizeButtonSize = (45.0.w).clamp(40.0, 55.0);

    return Consumer<ColorsSizesNotifier>(builder: (context, controller, child) {
      final sizes = context.read<ProductNotifier>().product!.sizes;

      // Tính toán số lượng kích thước tối đa trên mỗi hàng để tránh tràn
      // final itemsPerRow =
      //     ((screenWidth - 32) / (sizeButtonSize + 12.w)).floor();

      return Wrap(
        spacing: 12.w,
        runSpacing: 10.h,
        children: List.generate(
          sizes.length,
          (i) {
            String s = sizes[i];
            bool isSelected = controller.sizes == s;

            return GestureDetector(
              onTap: () {
                controller.setSizes(s);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: sizeButtonSize,
                width: sizeButtonSize,
                decoration: BoxDecoration(
                  color: isSelected ? Kolors.kPrimary : Kolors.kWhite,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: isSelected ? Kolors.kPrimary : Kolors.kGrayLight,
                    width: 1.5,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Kolors.kPrimary.withOpacity(0.3),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Kolors.kDark.withOpacity(0.05),
                            blurRadius: 4,
                            spreadRadius: 0.5,
                          ),
                        ],
                ),
                child: Center(
                  child: Text(
                    s,
                    style: TextStyle(
                      fontSize: 14
                          .sp
                          .clamp(12.0, 16.0), // Đảm bảo kích thước font phù hợp
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Kolors.kWhite : Kolors.kGray,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
