import 'package:comro_alt/common/widgets/images/rounded_image.dart';
import 'package:comro_alt/common/widgets/texts/product_title_text.dart';
import 'package:comro_alt/features/shop/models/cart_item_model.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CCartItem extends StatelessWidget {
  const CCartItem({
    required this.cartItem,
    super.key,
  });

  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //image
        CRoundedImage(
          imageUrl: cartItem.image ?? '',
          isNetworkImage: true,
          width: 65,
          height: 65,
          padding: const EdgeInsets.all(CSizes.sm),
          backgroundColor: Colors.transparent,
          applyImageRadius: true,
        ),

        //title, price, size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //title
              Flexible(
                child: CProductTitleText(
                  title: cartItem.title,
                  maxLines: 1,
                  smallSize: true,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
