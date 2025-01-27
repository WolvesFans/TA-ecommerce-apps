import 'package:comro_alt/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:comro_alt/common/widgets/texts/product_price_text.dart';
import 'package:comro_alt/common/widgets/texts/product_title_text.dart';
import 'package:comro_alt/common/widgets/texts/section_heading.dart';
import 'package:comro_alt/utils/constants/colors.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

class CProductAttributes extends StatelessWidget {
  const CProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        // selected attributes pricing & desc
        CRoundedContainer(
          padding: const EdgeInsets.all(CSizes.md),
          backgroundColor: dark ? CColors.darkerGrey : CColors.darkGrey.withOpacity(0.3),
          child: Column(
            children: [
              //title n price
              Row(
                children: [
                  const CSectionHeading(title: 'Variation'),
                  const SizedBox(width: CSizes.spaceBtwItems),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const CProductTitleText(
                            title: 'Price: ',
                            smallSize: true,
                          ),

                          //actual price
                          Text(
                            '2.000',
                            style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough),
                          ),
                          const SizedBox(width: CSizes.spaceBtwItems / 1.5),

                          //sale price
                          const CProductPriceText(currencySign: '', price: '1.500')
                        ],
                      ),

                      //stock info
                      Row(
                        children: [
                          const CProductTitleText(
                            title: 'Stock: ',
                            smallSize: true,
                          ),
                          Text(
                            'In Stock',
                            style: Theme.of(context).textTheme.titleMedium,
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: CSizes.spaceBtwItems / 1.2),

              //product description
              CProductTitleText(
                title: loremIpsum(words: 20),
                smallSize: true,
                maxLines: 4,
              )
            ],
          ),
        ),
        const SizedBox(height: CSizes.spaceBtwSections),

        //attributes  
      ],
    );
  }
}
