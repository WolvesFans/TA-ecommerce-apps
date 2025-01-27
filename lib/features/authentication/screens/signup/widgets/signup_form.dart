import 'package:comro_alt/features/authentication/controllers/signup/signup_controller.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/constants/text_strings.dart';
import 'package:comro_alt/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';

class CSignupForm extends StatelessWidget {
  const CSignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          //name
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) => CValidators.validateEmptyText('First Name', value),
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: CText.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              const SizedBox(width: CSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) => CValidators.validateEmptyText('Last Name', value),
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: CText.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: CSizes.spaceBtwInputFields),

          //username
          TextFormField(
            controller: controller.username,
            validator: (value) => CValidators.validateEmptyText('Username', value),
            expands: false,
            decoration: const InputDecoration(
              labelText: CText.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          const SizedBox(height: CSizes.spaceBtwInputFields),

          //email
          TextFormField(
            controller: controller.email,
            validator: (value) => CValidators.validateEmail(value),
            expands: false,
            decoration: const InputDecoration(
              labelText: CText.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(height: CSizes.spaceBtwInputFields),

          //password
          Obx(
            () => TextFormField(
              controller: controller.password,
              validator: (value) => CValidators.validatePassword(value),
              obscureText: controller.hidePassword.value,
              expands: false,
              decoration: InputDecoration(
                labelText: CText.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                  icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye),
                ),
              ),
            ),
          ),
          const SizedBox(height: CSizes.spaceBtwInputFields),

          //phone number
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => CValidators.validatePhoneNumber(value),
            decoration: const InputDecoration(
              labelText: CText.phoneNumber,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(height: CSizes.spaceBtwInputFields),

          //sign up button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: const Text(
                CText.createAccount,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
