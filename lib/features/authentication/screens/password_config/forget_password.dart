import 'package:comro_alt/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/constants/text_strings.dart';
import 'package:comro_alt/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(CSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //heading
            Text(
              CText.forgetPasswordTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: CSizes.spaceBtwItems),
            Text(
              CText.forgetPasswordSubtitle,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: CSizes.spaceBtwSections * 1.5),

            //textfield
            Form(
              key: controller.forgetPasswordFormKey,
              child: TextFormField(
                controller: controller.email,
                validator: CValidators.validateEmail,
                decoration: const InputDecoration(
                  labelText: CText.email,
                  prefixIcon: Icon(Iconsax.direct_right),
                ),
              ),
            ),
            const SizedBox(height: CSizes.spaceBtwInputFields),

            //submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.sendPasswordResetEmail(),
                child: const Text(CText.submit),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
