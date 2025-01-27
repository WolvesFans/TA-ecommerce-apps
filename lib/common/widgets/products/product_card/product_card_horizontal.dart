import 'package:comro_alt/common/widgets/images/rounded_image.dart';
import 'package:comro_alt/common/widgets/products/product_card/product_add_to_cart_button.dart';
import 'package:comro_alt/common/widgets/texts/product_price_text.dart';
import 'package:comro_alt/common/widgets/texts/product_title_text.dart';
import 'package:comro_alt/features/shop/models/product_model.dart';
import 'package:comro_alt/features/shop/screens/product_details/product_details.dart';
import 'package:comro_alt/utils/constants/colors.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';

class CProductCardHorizontal extends StatelessWidget {
  const CProductCardHorizontal({
    super.key,
    this.applyAddButton = true,
    this.onTap,
    required this.product,
  });

  final bool applyAddButton;
  final VoidCallback? onTap;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetail(product: product)),
      child: Container(
        height: 125,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(CSizes.productImageRadius),
          color: dark ? CColors.darkerGrey : CColors.white,
          border: Border.all(color: dark ? Colors.transparent : CColors.darkerGrey),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: CSizes.sm),
          child: Row(
            children: [
              //product image
              CRoundedImage(
                isNetworkImage: true,
                imageUrl: product.thumbnail,
                applyImageRadius: true,
                height: 100,
                width: 100,
              ),
              const SizedBox(width: CSizes.spaceBtwItems),

              //details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: CSizes.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //product title
                      CProductTitleText(
                        title: product.title,
                      ),

                      //product description
                      Text(
                        product.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      const Spacer(),

                      //price & add to cart
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //price
                          CProductPriceText(
                            currencySign: 'Rp ',
                            price: product.price.toString(),
                          ),

                          //add to cart
                          ProductAddToCartButton(product: product),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

