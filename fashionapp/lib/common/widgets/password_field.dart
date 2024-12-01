// ignore_for_file: use_super_parameters

import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/src/auth/controllers/password_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    Key? key,
    required this.controller,
    this.focusNode,
    this.radius,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode? focusNode;
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return Consumer<PasswordNotifier>(
      builder: (context, passwordNotifier, child) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: TextFormField(
            cursorColor: Colors.black,
            textInputAction: TextInputAction.next,
            focusNode: focusNode,
            keyboardType: TextInputType.visiblePassword,
            controller: controller,
            obscureText: passwordNotifier.password,
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter a valid password";
              } else {
                return null;
              }
            },
            style: appStyle(12, Kolors.kDark, FontWeight.normal),
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: () {
                  passwordNotifier.setPassword();
                },
                child: Icon(
                  passwordNotifier.password
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Kolors.kGrayLight,
                ),
              ),
              hintText: 'Password ',
              prefixIcon: const Icon(
                CupertinoIcons.lock_circle,
                color: Kolors.kGrayLight,
                size: 26,
              ),
              isDense: true,
              contentPadding: const EdgeInsets.all(6),
              hintStyle: appStyle(12, Kolors.kGray, FontWeight.normal),
              // contentPadding: EdgeInsets.only(left: 24),
              errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 0.5),
                  borderRadius:
                      BorderRadius.all(Radius.circular(radius ?? 12))),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Kolors.kPrimary, width: 0.5),
                  borderRadius:
                      BorderRadius.all(Radius.circular(radius ?? 12))),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Kolors.kRed, width: 0.5),
                  borderRadius:
                      BorderRadius.all(Radius.circular(radius ?? 12))),
              disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Kolors.kGray, width: 0.5),
                  borderRadius:
                      BorderRadius.all(Radius.circular(radius ?? 12))),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Kolors.kGray, width: 0.5),
                  borderRadius:
                      BorderRadius.all(Radius.circular(radius ?? 12))),
              border: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Kolors.kPrimary, width: 0.5),
                borderRadius: BorderRadius.all(
                  Radius.circular(radius ?? 12),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
