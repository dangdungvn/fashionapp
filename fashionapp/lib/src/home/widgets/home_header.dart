import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Category title with modern styling
          const Text(
            AppText.kCategory,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Kolors.kDark,
              letterSpacing: 0.5,
            ),
          ),

          // View All button with enhanced styling
          GestureDetector(
            onTap: () {
              context.push('/categories');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Kolors.kPrimary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                AppText.kViewAll,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Kolors.kPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
