import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/src/products/controller/product_notifier.dart';
import 'package:fashionapp/src/products/models/products_model.dart';
import 'package:fashionapp/src/wishlist/controllers/wishlist_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:like_button/like_button.dart';

class StaggeredTileWidget extends StatefulWidget {
  const StaggeredTileWidget({
    super.key,
    required this.i,
    required this.product,
    this.onTap,
  });
  final int i;
  final Products product;
  final void Function()? onTap;

  @override
  State<StaggeredTileWidget> createState() => _StaggeredTileWidgetState();
}

class _StaggeredTileWidgetState extends State<StaggeredTileWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ProductNotifier>().setProduct(widget.product);
        context.push('/product/${widget.product.id}');
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Kolors.kOffWhite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: widget.i % 2 == 0 ? 163.h : 180.h,
                color: Kolors.kOffWhite,
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      height: widget.i % 2 == 0 ? 163.h : 180.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      imageUrl: widget.product.imageUrls[0],
                    ),
                    Positioned(
                      right: 10.h,
                      top: 10.h,
                      child: Consumer<WishlistNotifier>(
                        builder: (context, wishlistNotifier, child) {
                          return LikeButton(
                            size: 25,
                            circleColor: const CircleColor(
                                start: Color(0xff00ddff),
                                end: Color(0xff0099cc)),
                            bubblesColor: const BubblesColor(
                              dotPrimaryColor: Colors.pink,
                              dotSecondaryColor: Colors.white,
                            ),
                            isLiked: wishlistNotifier.wishlist
                                .contains(widget.product.id),
                            onTap: (isLiked) async {
                              if (widget.onTap != null) {
                                widget.onTap!();
                              }
                              return !isLiked;
                            },
                            likeBuilder: (bool isLiked) {
                              return Icon(
                                Icons.favorite,
                                color: isLiked
                                    ? Colors.red
                                    : Colors.grey.withOpacity(0.5),
                                size: 25,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Text(
                        widget.product.title,
                        overflow: TextOverflow.ellipsis,
                        style: appStyle(13, Kolors.kDark, FontWeight.w600),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(AntDesign.star,
                            color: Kolors.kGold, size: 14),
                        SizedBox(
                          width: 5.w,
                        ),
                        ReusableText(
                          text: widget.product.ratings.toStringAsFixed(1),
                          style: appStyle(13, Kolors.kGray, FontWeight.normal),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: ReusableText(
                  text: '\$ ${widget.product.price.toStringAsFixed(2)}',
                  style: appStyle(17, Kolors.kDark, FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
