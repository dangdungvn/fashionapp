import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/src/cart/controllers/cart_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class CartCounter extends StatelessWidget {
  const CartCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartNotifier>(builder: (
      context,
      cartNotifier,
      child,
    ) {
      return SizedBox(
        height: 23.h,
        width: 60.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                cartNotifier.decrement();
              },
              child: const Icon(
                AntDesign.minussquareo,
                color: Kolors.kPrimary,
                size: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: ReusableText(
                text: "${cartNotifier.qty}",
                style: appStyle(13, Kolors.kDark, FontWeight.w500),
              ),
            ),
            GestureDetector(
              onTap: () {
                cartNotifier.increment();
              },
              child: const Icon(
                AntDesign.plussquareo,
                color: Kolors.kPrimary,
                size: 20,
              ),
            ),
          ],
        ),
      );
    });
  }
}
