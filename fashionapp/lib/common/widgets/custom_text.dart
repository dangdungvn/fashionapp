import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.prefixIcon,
    this.keyboardType,
    this.onEditingComplete,
    this.controller,
    this.hintText,
    this.focusNode,
    this.initialValue,
    this.maxLines,
  });
  final String? hintText;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final void Function()? onEditingComplete;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? initialValue;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        cursorColor: Colors.black,
        maxLines: maxLines ?? 1,
        textInputAction: TextInputAction.next,
        onEditingComplete: onEditingComplete,
        keyboardType: keyboardType,
        initialValue: initialValue,
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter a valid value";
          } else {
            return null;
          }
        },
        style: appStyle(12, Kolors.kDark, FontWeight.normal),
        decoration: InputDecoration(
          hintText: hintText,
          isDense: true,
          contentPadding: const EdgeInsets.all(9),
          hintStyle: appStyle(12, Kolors.kGray, FontWeight.normal),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 0.7),
              borderRadius: BorderRadius.all(Radius.circular(6))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Kolors.kPrimary, width: 0.7),
              borderRadius: BorderRadius.all(Radius.circular(6))),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 0.7),
              borderRadius: BorderRadius.all(Radius.circular(6))),
          disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Kolors.kGray, width: 0.7),
              borderRadius: BorderRadius.all(Radius.circular(6))),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Kolors.kGray, width: 0.7),
              borderRadius: BorderRadius.all(Radius.circular(6))),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Kolors.kPrimary, width: 0.7),
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
        ));
  }
}
