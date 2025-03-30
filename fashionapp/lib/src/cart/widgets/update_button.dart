import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/src/cart/controllers/cart_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class UpdateButton extends StatelessWidget {
  const UpdateButton({super.key, this.onUpdate});
  final void Function()? onUpdate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onUpdate,
      onLongPress: () {
        context.read<CartNotifier>().clearSelected();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: Kolors.kPrimary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Kolors.kPrimary.withOpacity(0.3),
              blurRadius: 8,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Kolors.kWhite,
              size: 16,
            ),
            SizedBox(width: 4.w),
            const Text(
              "Update",
              style: TextStyle(
                color: Kolors.kWhite,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
