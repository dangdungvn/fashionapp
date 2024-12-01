import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/const/constants.dart';
import 'package:fashionapp/src/products/controller/colors_sizes_notifier.dart';
import 'package:fashionapp/src/products/controller/product_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ColorColectionWidget extends StatelessWidget {
  const ColorColectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ColorsSizesNotifier>(
      builder: (context, controller, child) {
        return Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            context.read<ProductNotifier>().product!.colors.length,
            (i) {
              String c = context.read<ProductNotifier>().product!.colors[i];
              return GestureDetector(
                onTap: () {
                  controller.setColors(c);
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                  child: Container(
                    padding: EdgeInsets.only(
                        right: 20.w, left: 20.w, top: 5.h, bottom: 5.h),
                    // margin: EdgeInsets.only(right: 20.w,),
                    decoration: BoxDecoration(
                      borderRadius: kRadiusAll,
                      color: c == controller.colors
                          ? Kolors.kPrimary
                          : Kolors.kGrayLight,
                    ),
                    child: ReusableText(
                      text: c,
                      style: appStyle(12, Kolors.kWhite, FontWeight.normal),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
