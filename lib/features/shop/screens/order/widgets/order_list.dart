import 'package:comro_alt/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:comro_alt/common/widgets/loaders/animation_loader.dart';
import 'package:comro_alt/features/shop/controllers/order_controller.dart';
import 'package:comro_alt/features/shop/screens/store/store.dart';
import 'package:comro_alt/utils/constants/colors.dart';
import 'package:comro_alt/utils/constants/image_strings.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/helpers/cloud_helper_functions.dart';
import 'package:comro_alt/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class COrderListItems extends StatelessWidget {
  const COrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    final controller = OrderController.instance;
    return FutureBuilder(
      future: controller.fetchUserOrders(),
      builder: (_, snapshot) {
        //nothing found widget
        final emptyWidget = CAnimationLoaderWidget(
          text: 'Whoops, no order yet!',
          animation: CImage.loadingAnimation,
          showAction: true,
          actionText: 'Le\'ts fill it!',
          onActionPressed: () => Get.off(() => const StoreScreen()),
        );

        //helper function: handle loader, no record, or error message
        final response = CCloudHelperFunctions.checkMultiRecordState(
          snapshot: snapshot,
          nothingFound: emptyWidget,
        );
        if (response != null) return response;

        //record found
        final orders = snapshot.data!;
        return ListView.separated(
            shrinkWrap: true,
            itemCount: orders.length,
            separatorBuilder: (_, index) => const SizedBox(height: CSizes.spaceBtwItems),
            itemBuilder: (_, index) {
              final order = orders[index];
              return CRoundedContainer(
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
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyLarge!.apply(color: CColors.primary, fontWeightDelta: 1),
                              ),
                              const SizedBox(height: CSizes.spaceBtwItems / 4),
                              Text(
                                order.formattedOrderDate,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    //row 2
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Iconsax.arrow_right_34,
                          size: CSizes.iconSm,
                        ),
                      ],
                    ),

                    //row 3 - order number n deliv date
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
                                      order.id,
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
                                    order.formattedDeliveryDate,
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
              );
            });
      },
    );
  }
}
