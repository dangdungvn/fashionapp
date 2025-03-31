import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/src/products/controller/colors_sizes_notifier.dart';
import 'package:fashionapp/src/products/controller/product_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ColorColectionWidget extends StatelessWidget {
  ColorColectionWidget({super.key});

  final Map<String, Color> colorMap = {
    'black': Colors.black,
    'yellow': Colors.yellow,
    'green': Colors.green,
    'gray': Colors.grey,
    'purple': Colors.purple,
    "khaki": Colors.amber,
    "navy": Colors.indigo,
    "blue": Colors.blue,
    "dark blue": Colors.indigo,
    "light blue": Colors.lightBlue,
    "beige": const Color(0xFFF5F5DC),
    "pink": Colors.pink,
    "brown": Colors.brown,
    "red": Colors.red,
    "white": Colors.white,
    "denim blue": Colors.blueGrey,
    "orange": Colors.orange,
    "grey": Colors.grey,
    // Add more colors as needed
  };

  Color getColorFromName(String colorName) {
    return colorMap[colorName.toLowerCase()] ?? Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ColorsSizesNotifier>(
      builder: (context, controller, child) {
        return Wrap(
          spacing: 12.w,
          runSpacing: 10.h,
          children: List.generate(
            context.read<ProductNotifier>().product!.colors.length,
            (i) {
              String colorName =
                  context.read<ProductNotifier>().product!.colors[i];
              Color colorValue = getColorFromName(colorName);
              bool isSelected = colorName == controller.colors;

              return GestureDetector(
                onTap: () {
                  controller.setColors(colorName);
                },
                child: Column(
                  children: [
                    // Color Circle
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorValue,
                        border: Border.all(
                          color: isSelected
                              ? Kolors.kPrimary
                              : (colorValue == Colors.white
                                  ? Kolors.kGrayLight
                                  : Colors.transparent),
                          width: 2.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isSelected
                                ? Kolors.kPrimary.withOpacity(0.3)
                                : Kolors.kDark.withOpacity(0.05),
                            blurRadius: isSelected ? 8 : 4,
                            spreadRadius: isSelected ? 2 : 0.5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: isSelected
                          ? Center(
                              child: Icon(
                                Icons.check,
                                color: colorValue.computeLuminance() > 0.5
                                    ? Colors.black
                                    : Colors.white,
                                size: 18,
                              ),
                            )
                          : null,
                    ),

                    // Color Name
                    SizedBox(height: 5.h),
                    Text(
                      colorName,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                        color: isSelected ? Kolors.kPrimary : Kolors.kGray,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
