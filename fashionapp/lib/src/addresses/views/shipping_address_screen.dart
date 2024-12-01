import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/back_button.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/common/widgets/shimmers/list_shimmer.dart';
import 'package:fashionapp/const/constants.dart';
import 'package:fashionapp/src/addresses/controllers/address_notifier.dart';
import 'package:fashionapp/src/addresses/hooks/fetch_address_list.dart';
import 'package:fashionapp/src/addresses/widgets/address_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
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
      appBar: AppBar(
        leading: const AppBackButton(),
        centerTitle: true,
        title: ReusableText(
          text: AppText.kAddresses,
          style: appStyle(16, Kolors.kPrimary, FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        children: List.generate(
          addresses.length,
          (i) {
            final address = addresses[i];
            return AddressTile(
                onDelete: () {
                  context
                      .read<AddressNotifier>()
                      .deleteAddress(address.id, refetch, context);
                },
                setDefault: () {
                  context
                      .read<AddressNotifier>()
                      .setAsDefault(address.id, refetch, context);
                },
                address: address,
                isCheckout: false);
          },
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          context.push('/addaddress');
        },
        child: Container(
          height: 80,
          width: ScreenUtil().screenWidth,
          decoration: BoxDecoration(
            color: Kolors.kPrimaryLight,
            borderRadius: kRadiusTop,
          ),
          child: Center(
            child: ReusableText(
              text: "Add Address",
              style: appStyle(16, Kolors.kWhite, FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
