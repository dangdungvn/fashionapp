import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/src/cart/controllers/cart_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartCounter extends StatelessWidget {
  const CartCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartNotifier>(
      builder: (context, cartNotifier, child) {
        return Container(
          height: 32.h,
          decoration: BoxDecoration(
            color: Kolors.kOffWhite,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: Kolors.kGray.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Decrement button
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    cartNotifier.decrement();
                  },
                  borderRadius: BorderRadius.circular(16.r),
                  child: Container(
                    width: 28.w,
                    height: 28.h,
                    decoration: BoxDecoration(
                      color: cartNotifier.qty <= 1
                          ? Kolors.kGray.withOpacity(0.1)
                          : Kolors.kPrimaryLight.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.remove,
                      color: cartNotifier.qty <= 1
                          ? Kolors.kGray
                          : Kolors.kPrimary,
                      size: 16,
                    ),
                  ),
                ),
              ),

              // Quantity display
              Container(
                width: 32.w,
                alignment: Alignment.center,
                child: Text(
                  "${cartNotifier.qty}",
                  style: GoogleFonts.poppins(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: Kolors.kDark,
                  ),
                ),
              ),

              // Increment button
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    cartNotifier.increment();
                  },
                  borderRadius: BorderRadius.circular(16.r),
                  child: Container(
                    width: 28.w,
                    height: 28.h,
                    decoration: BoxDecoration(
                      color: Kolors.kPrimaryLight.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.add,
                      color: Kolors.kPrimary,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
