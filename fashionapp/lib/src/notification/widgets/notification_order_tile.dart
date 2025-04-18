import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/src/orders/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:iconly/iconly.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationOrderTile extends StatelessWidget {
  final Order order;

  const NotificationOrderTile({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Kolors.kWhite,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Kolors.kDark.withOpacity(0.03),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Header
          _buildOrderHeader(),

          // Divider
          Divider(
            color: Kolors.kGrayLight.withOpacity(0.5),
            thickness: 1,
            indent: 16.w,
            endIndent: 16.w,
          ),

          // Order Products List
          Column(
            children: List.generate(order.orderProducts.length, (i) {
              final product = order.orderProducts[i];
              return _buildOrderProductItem(product, context);
            }),
          ),

          // Order Footer with total price
          _buildOrderFooter(),
        ],
      ),
    );
  }

  Widget _buildOrderHeader() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Order ID and Status
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    IconlyBold.document,
                    size: 16.sp,
                    color: Kolors.kPrimary,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    "Đơn hàng #${order.id.toString().substring(0, 2)}",
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Kolors.kDark,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 4.h,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getStatusIcon(),
                      size: 12.sp,
                      color: _getStatusColor(),
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      order.deliveryStatus,
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: _getStatusColor(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Order Date
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatDate(order.createdAt),
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: Kolors.kGray,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                "${order.orderProducts.length} sản phẩm",
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: Kolors.kPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderProductItem(OrderProduct product, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 70.w,
            height: 70.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              boxShadow: [
                BoxShadow(
                  color: Kolors.kDark.withOpacity(0.05),
                  blurRadius: 8,
                  spreadRadius: 1,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: CachedNetworkImage(
                imageUrl: product.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Kolors.kOffWhite,
                  child: Center(
                    child: SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Kolors.kPrimary,
                      ),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Kolors.kOffWhite,
                  child: Icon(
                    Icons.error_outline,
                    color: Kolors.kGray,
                    size: 24.sp,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: 12.w),

          // Product details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product title
                Text(
                  product.title,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Kolors.kDark,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: 5.h),

                // Product variation
                Row(
                  children: [
                    _buildVariationBadge(
                      "Size: ${product.size.toUpperCase()}",
                      Kolors.kGold,
                    ),
                    SizedBox(width: 8.w),
                    _buildVariationBadge(
                      "Màu: ${product.color}",
                      Kolors.kPrimaryLight,
                    ),
                  ],
                ),

                SizedBox(height: 5.h),

                // Price and quantity
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${product.price.toStringAsFixed(2)}",
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Kolors.kPrimary,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: Kolors.kOffWhite,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        "x${product.quantity}",
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Kolors.kGray,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderFooter() {
    // Calculate total
    double total = 0;
    for (var product in order.orderProducts) {
      total += product.price * product.quantity;
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Kolors.kPrimaryLight.withOpacity(0.05),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tổng cộng",
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: Kolors.kGray,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "\$${total.toStringAsFixed(2)}",
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Kolors.kPrimary,
                ),
              ),
            ],
          ),

          // Action button
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 8.h,
            ),
            decoration: BoxDecoration(
              color: Kolors.kPrimary,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Kolors.kPrimary.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  IconlyLight.arrow_right,
                  size: 16.sp,
                  color: Kolors.kWhite,
                ),
                SizedBox(width: 5.w),
                Text(
                  "Xem chi tiết",
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Kolors.kWhite,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVariationBadge(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 3.h,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }

  // Helper functions
  Color _getStatusColor() {
    switch (order.deliveryStatus.toLowerCase()) {
      case 'pending':
        return Kolors.kGold;
      case 'processing':
        return Kolors.kBlue;
      case 'delivered':
        return Kolors.kGreen;
      case 'cancelled':
        return Kolors.kRed;
      default:
        return Kolors.kPrimary;
    }
  }

  IconData _getStatusIcon() {
    switch (order.deliveryStatus.toLowerCase()) {
      case 'pending':
        return IconlyBold.time_circle;
      case 'processing':
        return IconlyBold.activity;
      case 'delivered':
        return IconlyBold.tick_square;
      case 'cancelled':
        return IconlyBold.close_square;
      default:
        return IconlyBold.document;
    }
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
