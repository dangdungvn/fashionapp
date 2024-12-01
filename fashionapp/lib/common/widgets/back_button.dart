import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:fashionapp/common/utils/kcolors.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
    this.color,
    this.size,
    this.onTap,
  });

  final Color? color;
  final double? size;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => GoRouter.of(context).pop(),
      child: Icon(AntDesign.leftcircle,
          color: color ?? Kolors.kPrimary, size: size ?? 24),
    );
  }
}
