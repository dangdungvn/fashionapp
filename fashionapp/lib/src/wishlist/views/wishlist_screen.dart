import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/const/resource.dart';
import 'package:fashionapp/src/auth/views/login_screen.dart';
import 'package:fashionapp/src/wishlist/widgets/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});
  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    if (accessToken == null) {
      return const LoginPage();
    }
    return Scaffold(
      backgroundColor: Kolors.kOffWhite,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          AppText.kWishlist,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Kolors.kDark,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Kolors.kOffWhite,
              Kolors.kWhite,
              Kolors.kSecondaryLight.withOpacity(0.3),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Decorative background elements
            Positioned(
              top: -50,
              right: -30,
              child: Container(
                width: 150.w,
                height: 150.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Kolors.kPrimary.withOpacity(0.05),
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              left: -50,
              child: Container(
                width: 180.w,
                height: 180.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Kolors.kPrimaryLight.withOpacity(0.05),
                ),
              ),
            ),

            // Main content
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header for wishlist with animation
                    Container(
                      margin: EdgeInsets.only(bottom: 15.h, top: 5.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Lottie.asset(
                                      R.ASSETS_ANIMATIONS_LOADING_JSON,
                                      width: 30.w,
                                      height: 30.w,
                                      repeat: true,
                                      animate: true,
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      "Sản phẩm yêu thích của bạn",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Kolors.kDark,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 35.w),
                                  child: Text(
                                    "Nơi lưu trữ những món đồ bạn ưng ý nhất",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Kolors.kGray,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: Kolors.kPrimary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Kolors.kPrimary.withOpacity(0.05),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  IconlyLight.filter,
                                  color: Kolors.kPrimary,
                                  size: 16,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  "Lọc",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Kolors.kPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Wishlist items grid with hero animation ready
                    const Expanded(
                      child: WishListWidget(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
