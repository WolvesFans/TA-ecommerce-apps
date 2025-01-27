import 'package:comro_alt/data/repositories/auth/auth_repository.dart';
import 'package:comro_alt/features/authentication/controllers/signup/verify_email_controller.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => AuthRepository.instance.logout(),
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
                CText.confirmEmail,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: CSizes.spaceBtwItems),
              Text(
                email ?? '',
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: CSizes.spaceBtwItems),
              Text(
                CText.verifEmailTitle,
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: CSizes.spaceBtwSections),

              //buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.checkEmailVerificationStatus(),
                  child: const Text(CText.cContinue),
                ),
              ),
              const SizedBox(height: CSizes.spaceBtwItems),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => controller.sendEmailVerification(),
                  child: const Text(CText.resendEmail),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
