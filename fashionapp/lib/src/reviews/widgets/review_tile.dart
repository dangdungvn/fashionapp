import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/const/constants.dart';
import 'package:fashionapp/src/reviews/controllers/rating_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ReviewTile extends StatelessWidget {
  const ReviewTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<RatingNotifier>(
      builder: (context, ratingNoifier, child) {
        return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ClipRRect(
                borderRadius: kRadiusAll,
                child: Container(
                  width: ScreenUtil().screenWidth,
                  height: 90,
                  color: Kolors.kWhite,
                  child: SizedBox(
                    height: 85.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(12),
                                      topRight: Radius.circular(12))),
                              child: ClipRRect(
                                borderRadius: kRadiusAll,
                                child: SizedBox(
                                  width: 76.w,
                                  height: double.infinity,
                                  child: Image.network(
                                    ratingNoifier.order!.imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReusableText(
                                    text: ratingNoifier.order!.title,
                                    style: appStyle(
                                        12, Kolors.kDark, FontWeight.normal)),
                                ReusableText(
                                    text:
                                        "Color : ${ratingNoifier.order!.color} "
                                            .toUpperCase(),
                                    style: appStyle(
                                        12, Kolors.kGray, FontWeight.normal)),
                                ReusableText(
                                    text: "Size : ${ratingNoifier.order!.size} "
                                        .toUpperCase(),
                                    style: appStyle(
                                        12, Kolors.kGray, FontWeight.normal)),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 6.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                onDoubleTap: () {},
                                child: Container(
                                  width: 40.w,
                                  height: 20.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Kolors.kPrimary,
                                        width: 0.5,
                                      ),
                                      borderRadius: BorderRadius.circular(4.0)),
                                  child: ReusableText(
                                      text:
                                          "* ${ratingNoifier.order!.quantity}",
                                      style: appStyle(12, Kolors.kPrimary,
                                          FontWeight.normal)),
                                ),
                              ),
                              SizedBox(
                                height: 6.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 6.w),
                                child: ReusableText(
                                    text:
                                        "\$ ${(ratingNoifier.order!.quantity * ratingNoifier.order!.price).toStringAsFixed(2)}",
                                    style: appStyle(
                                        12, Kolors.kPrimary, FontWeight.w600)),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )));
      },
    );
  }
}
