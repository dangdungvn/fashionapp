import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/const/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Kolors.kDark.withOpacity(0.05),
            blurRadius: 15,
            spreadRadius: 1,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            SizedBox(
              height: ScreenUtil().screenHeight * 0.2,
              width: ScreenUtil().screenWidth,
              child: ImageSlideshow(
                indicatorColor: Kolors.kPrimary,
                indicatorBackgroundColor: Kolors.kWhite,
                indicatorRadius: 4,
                onPageChanged: (index) {
                  // Optional: Do something when page changes
                },
                autoPlayInterval: 5000,
                isLoop: true,
                children: List.generate(
                  images.length,
                  (i) {
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        // Banner image
                        CachedNetworkImage(
                          placeholder: placeholder,
                          errorWidget: errorWidget,
                          imageUrl: images[i],
                          fit: BoxFit.cover,
                        ),

                        // Gradient overlay for better text visibility
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Kolors.kDark.withOpacity(0.6),
                                Kolors.kDark.withOpacity(0.1),
                              ],
                            ),
                          ),
                        ),

                        // Banner content
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Summer Collection",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Kolors.kWhite,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                "Discount up to 50% off\nfor your first purchase",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Kolors.kWhite.withOpacity(0.95),
                                  height: 1.3,
                                ),
                              ),
                              SizedBox(height: 15.h),
                              // Shop now button with modern style
                              ElevatedButton(
                                onPressed: () {
                                  // Navigate to category or collection
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Kolors.kWhite,
                                  foregroundColor: Kolors.kPrimary,
                                  elevation: 0,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                    vertical: 8.h,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: const Text(
                                  "Shop Now",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
