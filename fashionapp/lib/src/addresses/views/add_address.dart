// ignore_for_file: unused_element, camel_case_types

import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/common/widgets/back_button.dart';
import 'package:fashionapp/common/widgets/error_modal.dart';
import 'package:fashionapp/src/addresses/controllers/address_notifier.dart';
import 'package:fashionapp/src/addresses/models/create_address_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kolors.kOffWhite,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
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
        centerTitle: true,
        title: Text(
          AppText.kAddShipping,
          style: GoogleFonts.poppins(
            fontSize: 18,
            color: Kolors.kDark,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<AddressNotifier>(
        builder: (context, addressNotifier, child) {
          return Container(
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
                // Decorative elements
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
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 25.h),

                          // Form header
                          Container(
                            padding: EdgeInsets.all(15.w),
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
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10.w),
                                  decoration: BoxDecoration(
                                    color:
                                        Kolors.kPrimaryLight.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    IconlyBold.location,
                                    size: 24.sp,
                                    color: Kolors.kPrimary,
                                  ),
                                ),
                                SizedBox(width: 15.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Thêm địa chỉ giao hàng",
                                        style: GoogleFonts.poppins(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Kolors.kDark,
                                        ),
                                      ),
                                      Text(
                                        "Vui lòng nhập thông tin giao hàng của bạn",
                                        style: GoogleFonts.poppins(
                                          fontSize: 12.sp,
                                          color: Kolors.kGray,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 25.h),

                          // Form fields card
                          Container(
                            padding: EdgeInsets.all(20.w),
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
                                // Phone number field
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Số điện thoại",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Kolors.kDark,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    _buildTextField(
                                      hintText: "Nhập số điện thoại",
                                      keyboard: TextInputType.phone,
                                      controller: _phoneController,
                                      onSubmitted: (p) {},
                                      icon: IconlyLight.call,
                                    ),
                                  ],
                                ),

                                SizedBox(height: 20.h),

                                // Address field
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Address",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Kolors.kDark,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    _buildTextField(
                                      hintText: "Enter your full address",
                                      keyboard: TextInputType.text,
                                      controller: _addressController,
                                      onSubmitted: (p) {},
                                      icon: IconlyLight.location,
                                      maxLines: 3,
                                    ),
                                  ],
                                ),

                                SizedBox(height: 20.h),

                                // Address type selection
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Address Type",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Kolors.kDark,
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Row(
                                      children: List.generate(
                                        addressNotifier.addressTypes.length,
                                        (i) {
                                          final addressType =
                                              addressNotifier.addressTypes[i];
                                          return GestureDetector(
                                            onTap: () {
                                              addressNotifier
                                                  .setAddressType(addressType);
                                            },
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(right: 15.w),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 16.w,
                                                vertical: 8.h,
                                              ),
                                              decoration: BoxDecoration(
                                                color: addressNotifier
                                                            .addressType ==
                                                        addressType
                                                    ? Kolors.kPrimary
                                                    : Kolors.kWhite,
                                                borderRadius:
                                                    BorderRadius.circular(12.r),
                                                border: Border.all(
                                                  color: Kolors.kPrimary,
                                                  width: 1.5,
                                                ),
                                                boxShadow: addressNotifier
                                                            .addressType ==
                                                        addressType
                                                    ? [
                                                        BoxShadow(
                                                          color: Kolors.kPrimary
                                                              .withOpacity(0.2),
                                                          blurRadius: 8,
                                                          offset: const Offset(
                                                              0, 3),
                                                        ),
                                                      ]
                                                    : null,
                                              ),
                                              child: Text(
                                                addressType,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: addressNotifier
                                                              .addressType ==
                                                          addressType
                                                      ? Kolors.kWhite
                                                      : Kolors.kPrimary,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 20.h),

                                // Default address toggle
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 12.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        Kolors.kPrimaryLight.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Set as default address",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Kolors.kDark,
                                        ),
                                      ),
                                      CupertinoSwitch(
                                        value: addressNotifier.defaultToggle,
                                        thumbColor: Kolors.kWhite,
                                        activeTrackColor: Kolors.kPrimary,
                                        inactiveTrackColor: Kolors.kGrayLight,
                                        onChanged: (value) {
                                          addressNotifier
                                              .setDefaultToggle(value);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 30.h),

                          // Submit button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_addressController.text.isNotEmpty &&
                                    _phoneController.text.isNotEmpty &&
                                    addressNotifier.addressType != "") {
                                  CreateAddress address = CreateAddress(
                                    lat: 0.0,
                                    lng: 0.0,
                                    isDefault: addressNotifier.defaultToggle,
                                    address: _addressController.text,
                                    phone: _phoneController.text,
                                    addressType: addressNotifier.addressType,
                                  );
                                  String data = createAddressToJson(address);
                                  addressNotifier.addAddress(data, context);
                                } else {
                                  showErrorPopup(
                                      context,
                                      "Missing Address or Phone Number",
                                      "Error",
                                      false);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Kolors.kPrimary,
                                foregroundColor: Kolors.kWhite,
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                elevation: 2,
                                shadowColor: Kolors.kPrimary.withOpacity(0.3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    IconlyBold.tick_square,
                                    size: 20.sp,
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(
                                    "Save Address",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 30.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required TextEditingController controller,
    required void Function(String) onSubmitted,
    required IconData icon,
    TextInputType? keyboard,
    bool? readOnly,
    int? maxLines,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Kolors.kOffWhite,
        borderRadius: BorderRadius.circular(12.r),
        // border: Border.all(
        //   color: Kolors.kGrayLight,
        //   width: 1,
        // ),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboard,
        readOnly: readOnly ?? false,
        maxLines: maxLines ?? 1,
        style: GoogleFonts.poppins(
          fontSize: 14.sp,
          color: Kolors.kDark,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            fontSize: 14.sp,
            color: Kolors.kGray,
          ),
          prefixIcon: Icon(
            icon,
            color: Kolors.kPrimary,
            size: 20.sp,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
          border: InputBorder.none,
        ),
        onSubmitted: onSubmitted,
      ),
    );
  }
}
