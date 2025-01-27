import 'package:comro_alt/common/widgets/appbar/appbar.dart';
import 'package:comro_alt/features/personalization/controllers/user_controller.dart';
import 'package:comro_alt/utils/constants/colors.dart';
import 'package:comro_alt/utils/constants/text_strings.dart';
import 'package:comro_alt/utils/etc/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CHomeAppBar extends StatelessWidget {
  const CHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return CAppBar(
        title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          CText.homeAppBarTitle,
          style: Theme.of(context).textTheme.labelMedium!.apply(color: CColors.softGrey),
        ),
        Obx(() {
          if (controller.profileLoading.value) {
            return const CShimmerEffect(width: 80, height: 15);
          } else {
            return Text(controller.user.value.fullName, style: Theme.of(context).textTheme.headlineSmall!.apply(color: CColors.white));
          }
        }),
      ],
    ));
  }
}
