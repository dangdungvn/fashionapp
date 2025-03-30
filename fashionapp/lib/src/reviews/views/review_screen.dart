import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/back_button.dart';
import 'package:fashionapp/common/widgets/custom_text.dart';
import 'package:fashionapp/src/reviews/controllers/rating_notifier.dart';
import 'package:fashionapp/src/reviews/models/create_rating_model.dart';
import 'package:fashionapp/src/reviews/widgets/review_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({super.key});

  @override
  State<ReviewsPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewsPage> {
  final TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kolors.kOffWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Kolors.kOffWhite,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Kolors.kWhite.withOpacity(0.9),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Kolors.kDark.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: const AppBackButton(),
          ),
        ),
        title: const Text(
          "Đánh giá sản phẩm",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Kolors.kDark,
          ),
        ),
        centerTitle: true,
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
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(height: 15.h),

            // Thông tin sản phẩm trong card
            Container(
              decoration: BoxDecoration(
                color: Kolors.kWhite,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Kolors.kDark.withOpacity(0.05),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: EdgeInsets.all(15.w),
              child: const ReviewTile(),
            ),

            SizedBox(height: 20.h),

            // Tiêu đề đánh giá
            Container(
              padding: EdgeInsets.symmetric(vertical: 15.h),
              decoration: BoxDecoration(
                color: Kolors.kWhite,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Kolors.kDark.withOpacity(0.05),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    "Bạn đánh giá đơn hàng này như thế nào?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Kolors.kDark,
                    ),
                  ),
                  SizedBox(height: 15.h),

                  // Rating bar với thiết kế mới
                  RatingBar.builder(
                    initialRating: 3.0,
                    minRating: 1.0,
                    allowHalfRating: true,
                    itemSize: 45,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.w),
                    unratedColor: Kolors.kGrayLight,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star_rounded,
                      color: Kolors.kGold,
                    ),
                    onRatingUpdate: (rating) {
                      context.read<RatingNotifier>().setRating(rating);
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            // Khu vực nhập đánh giá
            Container(
              padding: EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                color: Kolors.kWhite,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Kolors.kDark.withOpacity(0.05),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Chia sẻ cảm nhận của bạn",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Kolors.kDark,
                    ),
                  ),

                  SizedBox(height: 15.h),

                  // Text field nhập review với thiết kế hiện đại
                  CustomTextField(
                    maxLines: 7,
                    controller: _reviewController,
                    hintText: "Viết đánh giá của bạn tại đây...",
                  ),
                ],
              ),
            ),

            SizedBox(height: 80.h), // Khoảng trống cho bottom bar
          ],
        ),
      ),

      // Bottom bar với các nút được thiết kế lại
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        decoration: BoxDecoration(
          color: Kolors.kWhite,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Kolors.kDark.withOpacity(0.08),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Nút hủy
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Kolors.kGrayLight.withOpacity(0.3),
                  foregroundColor: Kolors.kGray,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Hủy",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            SizedBox(width: 15.w),

            // Nút gửi đánh giá
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  var rating = CreateRating(
                    review: _reviewController.text,
                    rating: context.read<RatingNotifier>().rating,
                    product: context.read<RatingNotifier>().order!.productId,
                    order: context.read<RatingNotifier>().orderId,
                  );

                  String data = createRatingToJson(rating);
                  context.read<RatingNotifier>().addReview(data, context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Kolors.kPrimary,
                  foregroundColor: Kolors.kWhite,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Gửi đánh giá",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
