import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fashionapp/common/widgets/shimmers/shimmer_widget.dart';

class CatergoriesShimmer extends StatelessWidget {
  const CatergoriesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, top: 10),
      height: 75.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ShimmerWidget(
                    shimmerWidth: 70.w, shimmerHieght: 60.h, shimmerRadius: 12),
              ],
            );
          }),
    );
  }
}
