import 'package:comro_alt/common/widgets/appbar/appbar.dart';
import 'package:comro_alt/common/widgets/layouts/vertical_layout.dart';
import 'package:comro_alt/common/widgets/products/product_card/product_card_horizontal.dart';
import 'package:comro_alt/features/shop/controllers/product_controller.dart';
import 'package:comro_alt/features/shop/models/product_model.dart';
import 'package:comro_alt/utils/constants/colors.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/constants/text_strings.dart';
import 'package:comro_alt/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliver_tools/sliver_tools.dart';

class AdminViewProduct extends StatelessWidget {
  const AdminViewProduct({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    final controller = Get.put(ProductController());
    Get.put(ProductController());
    return Scaffold(
      appBar: CAppBar(
        showBackArrow: true,
        title: Text(
          'View Product',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(CSizes.defaultSpace),
        child: CustomScrollView(
          slivers: [
            //ala carte
            SliverPinnedHeader(
              child: ColoredBox(
                color: dark ? CColors.black : CColors.white,
                child: ListTile(
                  title: Text(
                    CText.alaCarte,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
            ),
            Obx(() {
              return SliverToBoxAdapter(
                child: CVerticalLayout(
                  itemCount: controller.storeAlaCarteProducts.length,
                  itemBuilder: (_, index) => CProductCardHorizontal(
                    product: controller.storeAlaCarteProducts[index],
                    applyAddButton: false,
                  ),
                ),
              );
            }),

            //bundle
            SliverPinnedHeader(
              child: ColoredBox(
                color: dark ? CColors.black : CColors.white,
                child: ListTile(
                  title: Text(
                    CText.bundle,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
            ),
            Obx(() {
              return SliverToBoxAdapter(
                child: CVerticalLayout(
                  itemCount: controller.storeBundleProducts.length,
                  itemBuilder: (_, index) => CProductCardHorizontal(
                    product: controller.storeBundleProducts[index],
                    applyAddButton: false,
                  ),
                ),
              );
            }),

            //beverages
          ],
        ),
      ),
    );
  }
}
