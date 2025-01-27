import 'package:comro_alt/common/widgets/appbar/appbar.dart';
import 'package:comro_alt/common/widgets/layouts/vertical_layout.dart';
import 'package:comro_alt/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:comro_alt/common/widgets/products/product_card/product_card_horizontal.dart';
import 'package:comro_alt/features/shop/controllers/product_controller.dart';
import 'package:comro_alt/utils/constants/colors.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/constants/text_strings.dart';
import 'package:comro_alt/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliver_tools/sliver_tools.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    final dark = CHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: CAppBar(
        title: Text(
          "Store",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: const [
          CCartCounterIcon(),
        ],
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
                  itemBuilder: (_, index) => CProductCardHorizontal(product: controller.storeAlaCarteProducts[index]),
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
                  itemBuilder: (_, index) => CProductCardHorizontal(product: controller.storeBundleProducts[index]),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
