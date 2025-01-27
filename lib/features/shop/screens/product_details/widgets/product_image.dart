import 'package:cached_network_image/cached_network_image.dart';
import 'package:comro_alt/common/widgets/appbar/appbar.dart';
import 'package:comro_alt/features/shop/controllers/image_controller.dart';
import 'package:comro_alt/features/shop/models/product_model.dart';
import 'package:comro_alt/utils/constants/colors.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CProductImage extends StatelessWidget {
  const CProductImage({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    final controller = Get.put(ImageController());
    controller.getAllProductImages(product);
    return Container(
      color: dark ? CColors.darkerGrey : CColors.light,
      child: Stack(
        children: [
          //main product
          Container(
            height: 300,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
            child: Padding(
              padding: const EdgeInsets.all(CSizes.productImageRadius * 2.5),
              child: Center(
                child: Obx(
                  () {
                    final image = controller.productImage.value;
                    return CachedNetworkImage(imageUrl: image);
                  },
                ),
              ),
            ),
          ),

          //appbar icons
          const CAppBar(
            showBackArrow: true,
          )
        ],
      ),
    );
  }
}
