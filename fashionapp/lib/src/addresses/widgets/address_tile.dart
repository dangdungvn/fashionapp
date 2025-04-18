import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/change_address_modal.dart';
import 'package:fashionapp/src/addresses/controllers/address_notifier.dart';
import 'package:fashionapp/src/addresses/models/addresses_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class AddressTile extends StatelessWidget {
  const AddressTile({
    super.key,
    required this.address,
    required this.isCheckout,
    this.setDefault,
    this.onDelete,
  });
  final AddressModel address;
  final bool isCheckout;
  final void Function()? setDefault;
  final void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressNotifier>(
      builder: (context, addressNotifier, child) {
        final bool isDefault = addressNotifier.address == null
            ? address.isDefault
            : addressNotifier.address!.isDefault;

        return Container(
          decoration: BoxDecoration(
            color: Kolors.kWhite,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Kolors.kDark.withOpacity(0.05),
                blurRadius: 8,
                spreadRadius: 1,
                offset: const Offset(0, 2),
              ),
            ],
            border: isDefault
                ? Border.all(
                    color: Kolors.kPrimary.withOpacity(0.5), width: 1.5)
                : null,
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Status indicator (default/not default)
                Container(
                  width: 12.w,
                  decoration: BoxDecoration(
                    color: isDefault ? Kolors.kPrimary : Colors.transparent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.r),
                      bottomLeft: Radius.circular(16.r),
                    ),
                  ),
                ),

                // Address icon and type
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: Kolors.kPrimaryLight.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _getAddressTypeIcon(addressNotifier, address),
                          size: 24.sp,
                          color: Kolors.kPrimary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        addressNotifier.address == null
                            ? address.addressType.toUpperCase()
                            : addressNotifier.address!.addressType
                                .toUpperCase(),
                        style: GoogleFonts.poppins(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: Kolors.kPrimary,
                        ),
                      ),
                    ],
                  ),
                ),

                // Address details
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 5.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Địa chỉ",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Kolors.kDark,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    addressNotifier.address == null
                                        ? address.address
                                        : addressNotifier.address!.address,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.sp,
                                      color: Kolors.kGray,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (isDefault)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Kolors.kPrimaryLight.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Text(
                                  "Mặc định",
                                  style: GoogleFonts.poppins(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Kolors.kPrimary,
                                  ),
                                ),
                              ),
                          ],
                        ),

                        SizedBox(height: 10.h),

                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(4.w),
                              decoration: BoxDecoration(
                                color: Kolors.kPrimaryLight.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                IconlyLight.call,
                                size: 12.sp,
                                color: Kolors.kPrimary,
                              ),
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              addressNotifier.address == null
                                  ? address.phone
                                  : addressNotifier.address!.phone,
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Kolors.kDark,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 15.h),

                        // Action buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (!isDefault && !isCheckout)
                              GestureDetector(
                                onTap: setDefault,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                    vertical: 6.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Kolors.kPrimary,
                                    borderRadius: BorderRadius.circular(8.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Kolors.kPrimary.withOpacity(0.2),
                                        blurRadius: 4,
                                        spreadRadius: 0,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    "Đặt làm mặc định",
                                    style: GoogleFonts.poppins(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Kolors.kWhite,
                                    ),
                                  ),
                                ),
                              ),
                            if (isCheckout)
                              GestureDetector(
                                onTap: () {
                                  changeAddressBottomSheet(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                    vertical: 6.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Kolors.kPrimary,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Text(
                                    "Sửa",
                                    style: GoogleFonts.poppins(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Kolors.kWhite,
                                    ),
                                  ),
                                ),
                              ),
                            if (!isDefault && !isCheckout) SizedBox(width: 8.w),
                            if (!isDefault && !isCheckout)
                              GestureDetector(
                                onTap: onDelete,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                    vertical: 6.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Kolors.kRed,
                                    borderRadius: BorderRadius.circular(8.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Kolors.kRed.withOpacity(0.2),
                                        blurRadius: 4,
                                        spreadRadius: 0,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    "Xóa",
                                    style: GoogleFonts.poppins(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Kolors.kWhite,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(width: 15.w),
              ],
            ),
          ),
        );
      },
    );
  }

  IconData _getAddressTypeIcon(
      AddressNotifier addressNotifier, AddressModel address) {
    final String type = addressNotifier.address == null
        ? address.addressType.toLowerCase()
        : addressNotifier.address!.addressType.toLowerCase();

    if (type == 'home') {
      return IconlyBold.home;
    } else if (type == 'office') {
      return IconlyBold.work;
    } else {
      return IconlyBold.location;
    }
  }
}
