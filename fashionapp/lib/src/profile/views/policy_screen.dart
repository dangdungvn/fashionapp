import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/common/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PolicyPage extends StatelessWidget {
  const PolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kolors.kOffWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Kolors.kOffWhite,
        centerTitle: true,
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
          AppText.kPolicy,
          style: TextStyle(
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
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          physics: const BouncingScrollPhysics(),
          children: [
            // Card chính sách hủy đơn hàng
            _buildPolicyCard(
              title: AppText.kCancelation,
              content: AppText.kAppCancelationPolicy,
              icon: Icons.cancel_outlined,
            ),

            SizedBox(height: 20.h),

            // Card điều khoản sử dụng
            _buildPolicyCard(
              title: AppText.kTerms,
              content: AppText.kAppTerms,
              icon: Icons.description_outlined,
            ),

            SizedBox(height: 20.h),

            // Card chính sách bảo mật
            _buildPolicyCard(
              title: "Chính sách bảo mật",
              content:
                  "Chúng tôi cam kết bảo vệ thông tin cá nhân của bạn và chỉ sử dụng thông tin này để cung cấp dịch vụ tốt nhất cho bạn. Thông tin cá nhân của bạn sẽ không được chia sẻ với bên thứ ba mà không có sự đồng ý của bạn.",
              icon: Icons.privacy_tip_outlined,
            ),

            SizedBox(height: 20.h),

            // Card chính sách vận chuyển
            _buildPolicyCard(
              title: "Chính sách vận chuyển",
              content:
                  "Chúng tôi cung cấp dịch vụ vận chuyển nhanh chóng và đáng tin cậy. Thời gian giao hàng thường từ 2-5 ngày làm việc tùy thuộc vào địa điểm của bạn. Chúng tôi sẽ thông báo cho bạn về trạng thái đơn hàng của bạn qua email hoặc ứng dụng.",
              icon: Icons.local_shipping_outlined,
            ),

            SizedBox(height: 20.h),

            // Card thông tin liên hệ
            Container(
              padding: EdgeInsets.all(20.w),
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
                  // Tiêu đề với icon
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: Kolors.kPrimaryLight.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.support_agent,
                          color: Kolors.kPrimary,
                          size: 22,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      const Text(
                        "Liên hệ hỗ trợ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Kolors.kDark,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 15.h),

                  // Email hỗ trợ
                  const Row(
                    children: [
                      Icon(
                        Icons.email_outlined,
                        color: Kolors.kGray,
                        size: 16,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "support@fashionapp.com",
                        style: TextStyle(
                          fontSize: 14,
                          color: Kolors.kGray,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8.h),

                  // Số điện thoại hỗ trợ
                  const Row(
                    children: [
                      Icon(
                        Icons.phone_outlined,
                        color: Kolors.kGray,
                        size: 16,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "+84 123 456 789",
                        style: TextStyle(
                          fontSize: 14,
                          color: Kolors.kGray,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8.h),

                  // Địa chỉ hỗ trợ
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Icon(
                          Icons.location_on_outlined,
                          color: Kolors.kGray,
                          size: 16,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "123 Đường Fashion, Quận 1, TP. Hồ Chí Minh, Việt Nam",
                          style: TextStyle(
                            fontSize: 14,
                            color: Kolors.kGray,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  // Helper method để tạo card chính sách
  Widget _buildPolicyCard({
    required String title,
    required String content,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(20.w),
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
          // Tiêu đề với icon
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: Kolors.kPrimaryLight.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Kolors.kPrimary,
                  size: 22,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Kolors.kDark,
                ),
              ),
            ],
          ),

          SizedBox(height: 15.h),

          // Nội dung chính sách
          Text(
            content,
            textAlign: TextAlign.justify,
            style: const TextStyle(
              fontSize: 14,
              color: Kolors.kGray,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
