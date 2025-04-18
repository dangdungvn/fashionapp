import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/common/widgets/back_button.dart';
import 'package:fashionapp/common/widgets/shimmers/list_shimmer.dart';
import 'package:fashionapp/const/resource.dart';
import 'package:fashionapp/src/addresses/controllers/address_notifier.dart';
import 'package:fashionapp/src/addresses/hooks/fetch_address_list.dart';
import 'package:fashionapp/src/addresses/widgets/address_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ShippingAddress extends HookWidget {
  const ShippingAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final results = fetchAddress();
    final addresses = results.address;
    final isLoading = results.isLoading;
    final refetch = results.refetch;

    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: ListShimmer(),
        ),
      );
    }

    context.read<AddressNotifier>().setRefetch(refetch);

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
          AppText.kAddresses,
          style: GoogleFonts.poppins(
            fontSize: 18,
            color: Kolors.kDark,
            fontWeight: FontWeight.bold,
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
              child: Column(
                children: [
                  SizedBox(height: 15.h),

                  // Header with animation
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Container(
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
                          Lottie.asset(
                            R.ASSETS_ANIMATIONS_LOADING_JSON,
                            width: 40.w,
                            height: 40.w,
                            repeat: true,
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Địa chỉ giao hàng cuả bạn",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Kolors.kDark,
                                  ),
                                ),
                                Text(
                                  "Quản lý địa chỉ giao hàng",
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
                  ),

                  SizedBox(height: 20.h),

                  // Addresses list
                  Expanded(
                    child: addresses.isEmpty
                        ? _buildEmptyAddressView(context)
                        : ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            physics: const BouncingScrollPhysics(),
                            itemCount: addresses.length,
                            itemBuilder: (context, i) {
                              final address = addresses[i];
                              return Padding(
                                padding: EdgeInsets.only(bottom: 15.h),
                                child: AddressTile(
                                  onDelete: () {
                                    context
                                        .read<AddressNotifier>()
                                        .deleteAddress(
                                            address.id, refetch, context);
                                  },
                                  setDefault: () {
                                    context
                                        .read<AddressNotifier>()
                                        .setAsDefault(
                                            address.id, refetch, context);
                                  },
                                  address: address,
                                  isCheckout: false,
                                ),
                              );
                            },
                          ),
                  ),

                  // Space for the button
                  SizedBox(height: 80.h),
                ],
              ),
            ),

            // Add address button
            Positioned(
              bottom: 20.h,
              left: 20.w,
              right: 20.w,
              child: GestureDetector(
                onTap: () {
                  context.push('/addaddress');
                },
                child: Container(
                  height: 55.h,
                  decoration: BoxDecoration(
                    color: Kolors.kPrimary,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Kolors.kPrimary.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        IconlyBold.plus,
                        color: Kolors.kWhite,
                        size: 20.sp,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "Add New Address",
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Kolors.kWhite,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyAddressView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            R.ASSETS_ANIMATIONS_LOADING_JSON,
            height: 150.h,
            repeat: true,
          ),
          SizedBox(height: 20.h),
          Text(
            "No Addresses Found",
            style: GoogleFonts.poppins(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Kolors.kDark,
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Text(
              "You haven't added any delivery addresses yet",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: Kolors.kGray,
              ),
            ),
          ),
          SizedBox(height: 30.h),
          ElevatedButton(
            onPressed: () {
              context.push('/addaddress');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Kolors.kPrimary,
              foregroundColor: Kolors.kWhite,
              padding: EdgeInsets.symmetric(
                horizontal: 25.w,
                vertical: 12.h,
              ),
              elevation: 2,
              shadowColor: Kolors.kPrimary.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  IconlyBold.location,
                  size: 18.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  "Add Your First Address",
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
