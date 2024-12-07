import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/src/products/controller/colors_sizes_notifier.dart';
import 'package:fashionapp/src/products/controller/product_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColorColectionWidget extends StatelessWidget {
  ColorColectionWidget({super.key});

  final Map<String, Color> colorMap = {
    'black': Colors.black,
    'yellow': Colors.yellow,
    'green': Colors.green,
    'gray': Colors.grey,
    'purple': Colors.purple,
    // Add more colors as needed
  };

  Color getColorFromName(String colorName) {
    return colorMap[colorName.toLowerCase()] ?? Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ColorsSizesNotifier>(
      builder: (context, controller, child) {
        return Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            context.read<ProductNotifier>().product!.colors.length,
            (i) {
              String c = context.read<ProductNotifier>().product!.colors[i];
              return GestureDetector(
                onTap: () {
                  controller.setColors(c);
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                  child: Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: getColorFromName(c),
                      border: Border.all(
                        color: c == controller.colors
                            ? Kolors.kPrimary
                            : Kolors.kGrayLight,
                        width: 2.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: c == controller.colors
                              ? Kolors.kPrimary
                              : Kolors.kGrayLight,
                          blurRadius: 5.0,
                          spreadRadius: 1.0,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
