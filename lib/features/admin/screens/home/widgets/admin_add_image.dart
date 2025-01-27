
import 'package:comro_alt/common/widgets/images/rounded_image.dart';
import 'package:comro_alt/features/admin/controllers/input_product_controller.dart';
import 'package:comro_alt/utils/constants/image_strings.dart';
import 'package:comro_alt/utils/etc/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminAddImage extends StatelessWidget {
  const AdminAddImage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = InputProductController.instance;
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //insert image
          Obx(() {
            final networkImage = controller.product.value.thumbnail;
            final image = networkImage.isNotEmpty ? networkImage : CImage.gehu;
            return controller.imageUploading.value
                ? const CShimmerEffect(
                    width: 150,
                    height: 150,
                    radius: 16,
                  )
                : CRoundedImage(
                    applyImageRadius: true,
                    imageUrl: image,
                    width: 150,
                    height: 150,
                    isNetworkImage: networkImage.isNotEmpty,
                  );
          }),

          // text button
          TextButton(
            onPressed: () => controller.uploadProductImage(),
            child: const Text('Insert/change product thumbnail'),
          ),

          
        ],
      ),
    );
  }
}
