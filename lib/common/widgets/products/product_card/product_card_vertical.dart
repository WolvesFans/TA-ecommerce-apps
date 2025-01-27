import 'package:comro_alt/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:comro_alt/common/widgets/images/rounded_image.dart';
import 'package:comro_alt/common/widgets/texts/product_price_text.dart';
import 'package:comro_alt/common/widgets/texts/product_title_text.dart';
import 'package:comro_alt/features/shop/models/product_model.dart';
import 'package:comro_alt/utils/constants/colors.dart';
import 'package:comro_alt/utils/constants/image_strings.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/constants/text_strings.dart';
import 'package:comro_alt/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CProductCardVertical extends StatelessWidget {
  const CProductCardVertical({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);

    //container side
    return GestureDetector(
      // onTap: () => Get.to(() => ProductDetail()),
      child: Container(
        width: 170,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(CSizes.productImageRadius),
            color: dark ? CColors.darkerGrey : CColors.white,
            border: Border.all(color: dark ? Colors.transparent : CColors.darkerGrey)),
        child: Column(
          children: [
            //thumbnails dll
            CRoundedContainer(
              height: 95,
              padding: const EdgeInsets.all(CSizes.sm),
              backgroundColor: dark ? Colors.transparent : CColors.light,
              child: const CRoundedImage(
                imageUrl: CImage.comro,
                applyImageRadius: true,
              ),
            ),
            const SizedBox(height: CSizes.spaceBtwItems / 2),

            //details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: CSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //product title
                  const CProductTitleText(
                    title: CText.comroTitle,
                    smallSize: true,
                  ),

                  //product subtitle
                  Text(
                    CText.comroSubtitle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(height: CSizes.spaceBtwItems),

                  //price & add to cart
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //price
                      const CProductPriceText(
                        currencySign: 'Rp ',
                        price: CText.defaultPrice,
                        maxLines: 1,
                      ),

                      //add to cart
                      Container(
                        decoration: BoxDecoration(
                          color: CColors.black,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const SizedBox(
                          width: CSizes.iconMd,
                          height: CSizes.iconMd,
                          child: Center(
                            child: Icon(
                              Iconsax.add,
                              color: CColors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
