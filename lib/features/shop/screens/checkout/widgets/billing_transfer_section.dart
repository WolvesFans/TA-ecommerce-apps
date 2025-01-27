import 'package:comro_alt/common/styles/spacing_styles.dart';
import 'package:comro_alt/common/widgets/images/rounded_image.dart';
import 'package:comro_alt/common/widgets/texts/section_heading.dart';
import 'package:comro_alt/features/shop/controllers/transfer_controller.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/etc/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CBillingTransferSection extends StatelessWidget {
  const CBillingTransferSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransferController());
    return Obx(
        () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CSectionHeading(
            title: 'Transfer Receipt',
            showActionButton: true,
            buttonTitle: 'Pick transfer receipt',
            onPressed: () => controller.pickImage(),
          ),
          controller.selectedImage == null
              ? const Text(
                'Upload your transfer receipt',
              )
              : Image.file(controller.selectedImage!),
        ],
      ),
    );
  }
}
