import 'package:comro_alt/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:comro_alt/features/authentication/screens/login/login.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({
    super.key,
    required this.email,
  });

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.close),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            children: [
              //title & subtitle
              Text(
                CText.resetPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: CSizes.spaceBtwItems),
              Text(
                email,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: CSizes.spaceBtwItems),
              Text(
                CText.resetPasswordSubtitle,
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: CSizes.spaceBtwSections),

              //buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.offAll(() => const LoginScreen()),
                  child: const Text(CText.done),
                ),
              ),
              const SizedBox(height: CSizes.spaceBtwItems),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => ForgetPasswordController.instance.resendPasswordResetEmail(email),
                  child: const Text(CText.resendEmail),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
