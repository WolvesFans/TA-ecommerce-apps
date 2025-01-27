import 'package:comro_alt/common/widgets/images/circular_image.dart';
import 'package:comro_alt/features/personalization/controllers/user_controller.dart';
import 'package:comro_alt/utils/constants/colors.dart';
import 'package:comro_alt/utils/constants/image_strings.dart';
import 'package:comro_alt/utils/etc/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

class CUserProfileTile extends StatelessWidget {
  const CUserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      leading: Obx(() {
        final networkImage = controller.user.value.profilePicture;
        final image = networkImage.isNotEmpty ? networkImage : CImage.gehu;
        return controller.imageUploading.value
            ? const CShimmerEffect(
                width: 50,
                height: 50,
                radius: 50,
              )
            : CCircularImage(
                image: image,
                width: 50,
                height: 50,
                isNetworkImage: networkImage.isNotEmpty,
              );
      }),
      title: Text(
        controller.user.value.fullName,
        style: Theme.of(context).textTheme.headlineSmall!.apply(color: CColors.white),
      ),
      subtitle: Text(
        controller.user.value.email,
        style: Theme.of(context).textTheme.bodyMedium!.apply(color: CColors.white),
      ),
      trailing: IconButton(
        onPressed: onPressed,
        icon: const Icon(
          Iconsax.edit,
          color: CColors.white,
        ),
      ),
    );
  }
}
