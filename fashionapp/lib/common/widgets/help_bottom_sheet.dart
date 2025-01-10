import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:url_launcher/url_launcher.dart';

Future<dynamic> showHelpCenterBottomSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Fashion App Help Center',
                style: appStyle(
                  18.0,
                  Kolors.kPrimary,
                  FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),

              // Information Section
              Text(
                'We\'re here to help! Find answers to frequently asked questions or contact our support team.',
                textAlign: TextAlign.center,
                style: appStyle(16.0, Kolors.kDark, FontWeight.normal),
              ),
              SizedBox(height: 15.h),

              // FAQ Section (Replace with actual FAQs)
              const Text(
                'FAQs:',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5.0),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Can I return an item?'),
                trailing: const Icon(
                  Icons.keyboard_arrow_right,
                  color: Kolors.kGray,
                ),
                onTap: () {
                  // Handle FAQ tap (open details page or show answer)
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('How do I track my order?'),
                trailing: const Icon(
                  Icons.keyboard_arrow_right,
                  color: Kolors.kGray,
                ),
                onTap: () {
                  // Handle FAQ tap (open details page or show answer)
                },
              ),

              const SizedBox(height: 15.0),

              // Contact Section
              const Text(
                'Contact Us:',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              const Row(
                children: [
                  Icon(MaterialCommunityIcons.email_outline),
                  SizedBox(width: 10.0),
                  Text(
                    'support@fashionapp.com',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              const Row(
                children: [
                  Icon(MaterialCommunityIcons.phone_outline),
                  SizedBox(width: 10.0),
                  Text(
                    '+860000000000',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              ElevatedButton(
                onPressed: () {
                  launchFacebook();
                },
                child: const Text('Visit Full Help Center'),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void launchFacebook() async {
  const url = 'https://www.messenger.com/t/100013745354364?locale=vi_VN';
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}
