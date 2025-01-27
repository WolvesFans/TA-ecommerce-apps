import 'package:comro_alt/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:comro_alt/utils/constants/colors.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CAdminOrderList extends StatelessWidget {
  const CAdminOrderList({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 10,
      separatorBuilder: (_, __) => const SizedBox(height: CSizes.spaceBtwItems),
      itemBuilder: (_, index) => CRoundedContainer(
        backgroundColor: dark ? CColors.dark : CColors.grey.withOpacity(0.2),
        showBorder: true,
        borderColor: dark ? CColors.white : CColors.black,
        padding: const EdgeInsets.all(CSizes.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //row 1 - order date
            Row(
              children: [
                //icon
                const Icon(Iconsax.calendar_2),
                const SizedBox(width: CSizes.spaceBtwItems / 2),

                //Order date
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Date',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: CSizes.spaceBtwItems / 4),
                      Text(
                        '06 July 2024',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),

                //right icon
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Iconsax.arrow_right_34,
                    size: CSizes.iconMd,
                  ),
                ),
              ],
            ),
            const SizedBox(height: CSizes.spaceBtwItems),

            //row 2 - order number n deliv date
            Row(
              children: [
                // row 2.1 - order number
                Expanded(
                  child: Row(
                    children: [
                      //icon
                      const Icon(Iconsax.tag),
                      const SizedBox(width: CSizes.spaceBtwItems / 2),

                      //order number
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order Number',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            const SizedBox(height: CSizes.spaceBtwItems / 4),
                            Text(
                              '[#3401]',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //row 2.2 - deliv date
                Expanded(
                  child: Row(
                    children: [
                      //icon
                      const Icon(Iconsax.calendar),
                      const SizedBox(width: CSizes.spaceBtwItems / 2),

                      //deliv date
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Delivery Date',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          const SizedBox(height: CSizes.spaceBtwItems / 4),
                          Text(
                            '10 July 2024',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    
  }
}
