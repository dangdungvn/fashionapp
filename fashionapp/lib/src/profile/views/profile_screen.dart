import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/common/widgets/help_bottom_sheet.dart';
import 'package:fashionapp/src/auth/controllers/auth_notifier.dart';
import 'package:fashionapp/src/auth/models/profile_model.dart';
import 'package:fashionapp/src/auth/views/login_screen.dart';
import 'package:fashionapp/src/entrypoint/controllers/bottom_tab_notifier.dart';
import 'package:fashionapp/src/profile/widgets/tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class ProfilePage extends HookWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');

    if (accessToken == null) {
      return const LoginPage();
    }

    return Scaffold(
      backgroundColor: Kolors.kOffWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Kolors.kOffWhite,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "Tài khoản",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Kolors.kDark,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              IconlyLight.setting,
              color: Kolors.kGray,
            ),
            onPressed: () {
              // Mở trang cài đặt
            },
          ),
          SizedBox(width: 8.w),
        ],
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
        child: Consumer<AuthNotifier>(
          builder: (context, authNotifier, child) {
            ProfileModel? user = authNotifier.getUserData();
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              physics: const BouncingScrollPhysics(),
              children: [
                SizedBox(height: 20.h),

                // Profile card với thiết kế hiện đại
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: Kolors.kWhite,
                    borderRadius: BorderRadius.circular(25),
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
                      // Avatar và thông tin người dùng
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(3.w),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Kolors.kPrimaryLight,
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Kolors.kPrimary.withOpacity(0.1),
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: const CircleAvatar(
                              radius: 35,
                              backgroundColor: Kolors.kOffWhite,
                              backgroundImage: AssetImage(AppText.kProfilePic),
                            ),
                          ),

                          SizedBox(width: 15.w),

                          // Thông tin người dùng
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user!.username,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Kolors.kDark,
                                  ),
                                ),

                                SizedBox(height: 5.h),

                                Text(
                                  user.email,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Kolors.kGray,
                                  ),
                                ),

                                SizedBox(height: 10.h),

                                // Nút chỉnh sửa
                                GestureDetector(
                                  onTap: () {
                                    // Mở trang chỉnh sửa profile
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: 6.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Kolors.kPrimary.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Text(
                                      "Chỉnh sửa",
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
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 25.h),

                // Danh sách tùy chọn với thiết kế hiện đại
                Container(
                  decoration: BoxDecoration(
                    color: Kolors.kWhite,
                    borderRadius: BorderRadius.circular(25),
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
                      ProfileTileWidget(
                        title: 'Đơn hàng của tôi',
                        leading: Octicons.checklist,
                        onTap: () {
                          context.push('/orders');
                        },
                      ),
                      _buildDivider(),
                      ProfileTileWidget(
                        title: 'Địa chỉ giao hàng',
                        leading: MaterialIcons.location_pin,
                        onTap: () {
                          context.push('/addresses');
                        },
                      ),
                      _buildDivider(),
                      ProfileTileWidget(
                        title: 'Chính sách & Quyền riêng tư',
                        leading: MaterialIcons.policy,
                        onTap: () {
                          context.push('/policy');
                        },
                      ),
                      _buildDivider(),
                      ProfileTileWidget(
                        title: 'Trung tâm hỗ trợ',
                        leading: AntDesign.customerservice,
                        onTap: () => showHelpCenterBottomSheet(context),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 25.h),

                // Nút đăng xuất với thiết kế hiện đại
                ElevatedButton(
                  onPressed: () {
                    Storage().removeKey('accessToken');
                    context.read<TabIndexNotifier>().setIndex(0);
                    context.go('/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Kolors.kRed.withOpacity(0.9),
                    foregroundColor: Kolors.kWhite,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.logout_rounded,
                        size: 20,
                      ),
                      SizedBox(width: 10.w),
                      const Text(
                        "Đăng xuất",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 50.h),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Divider(
        color: Kolors.kGrayLight.withOpacity(0.5),
        height: 1,
      ),
    );
  }
}
