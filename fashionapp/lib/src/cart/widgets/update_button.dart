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
        width: 65.w,
        height: 30.h,
        decoration: BoxDecoration(
          color: Kolors.kOffWhite,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.done_outlined, color: Kolors.kPrimary),
      ),
    );
  }
}
