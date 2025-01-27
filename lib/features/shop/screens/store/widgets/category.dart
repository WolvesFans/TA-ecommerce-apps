import 'package:comro_alt/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:comro_alt/features/shop/controllers/product_controller.dart';
import 'package:comro_alt/utils/constants/colors.dart';
import 'package:comro_alt/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  const Category({
    super.key,
    required this.title,
    this.widget,
  });

  final String title;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    final dark = CHelperFunctions.isDarkMode(context);
    if (controller.isLoading.value) return const  CVerticalProductShimmer();
    return MultiSliver(
      pushPinnedChildren: true,
      children: [
        SliverPinnedHeader(
          child: ColoredBox(
            color: dark ? CColors.black : CColors.white,
            child: ListTile(
              title: Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: widget,
        )
      ],
    );
  }
}
