import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/src/addresses/controllers/address_notifier.dart';
import 'package:fashionapp/src/addresses/models/addresses_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class SelectAddressTile extends StatelessWidget {
  const SelectAddressTile({
    super.key,
    required this.address,
  });
  final AddressModel address;

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressNotifier>(
      builder: (context, addressNotifier, child) {
        return ListTile(
          onTap: () {
            addressNotifier.setAddress(address);
            context.pop();
          },
          contentPadding: EdgeInsets.zero,
          leading: const CircleAvatar(
            radius: 28,
            backgroundColor: Kolors.kSecondaryLight,
            child: Icon(
              IconlyBold.location,
              color: Kolors.kPrimaryLight,
              size: 30,
            ),
          ),
          title: ReusableText(
            text: address.addressType.toUpperCase(),
            style: appStyle(13, Kolors.kDark, FontWeight.w400),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusableText(
                text: address.address,
                style: appStyle(11, Kolors.kGray, FontWeight.w400),
              ),
              ReusableText(
                text: address.phone,
                style: appStyle(11, Kolors.kGray, FontWeight.w400),
              ),
            ],
          ),
          trailing: ReusableText(
            text: addressNotifier.address != null &&
                    addressNotifier.address!.id == address.id
                ? "Selected"
                : "Select",
            style: appStyle(12, Kolors.kPrimaryLight, FontWeight.w400),
          ),
        );
      },
    );
  }
}
