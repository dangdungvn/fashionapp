import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/src/cart/controllers/cart_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UpdateButton extends StatelessWidget {
  const UpdateButton({super.key, this.onUpdate});
  final void Function()? onUpdate;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onUpdate,
        onLongPress: () {
          context.read<CartNotifier>().clearSelected();
        },
        borderRadius: BorderRadius.circular(12.r),
        child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: Kolors.kPrimary,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Kolors.kPrimary.withOpacity(0.2),
                blurRadius: 6,
                spreadRadius: 0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle_outline,
                color: Kolors.kWhite,
                size: 14.sp,
              ),
              SizedBox(width: 4.w),
              Text(
                "Cập nhật",
                style: GoogleFonts.poppins(
                  color: Kolors.kWhite,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
