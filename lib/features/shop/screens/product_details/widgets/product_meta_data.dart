import 'package:comro_alt/common/widgets/texts/product_price_text.dart';
import 'package:comro_alt/common/widgets/texts/product_title_text.dart';
// import 'package:comro_alt/features/shop/controllers/product_controller.dart';
import 'package:comro_alt/features/shop/models/product_model.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CProductMetaData extends StatelessWidget {
  const CProductMetaData({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    // final controller = ProductController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //title
        CProductTitleText(
          title: product.title,
        ),
        const SizedBox(height: CSizes.spaceBtwItems / 4),

        //product desc
        Text(
          product.description,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: CSizes.spaceBtwItems),

        Row(
          children: [
            //price
            CProductPriceText(
              isLarge: true,
              price: product.price,
            ),
          ],
        ),
      ],
    );
  }
}
