import 'package:comro_alt/features/authentication/controllers/login/login_controller.dart';
import 'package:comro_alt/utils/constants/colors.dart';
import 'package:comro_alt/utils/constants/image_strings.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CSocialButton extends StatelessWidget {
  const CSocialButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: CColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () => controller.googleSignIn(),
            icon: const Image(
              image: AssetImage(CImage.googleIcon),
              width: CSizes.md,
              height: CSizes.md,
            ),
          ),
        )
      ],
    );
  }
}
