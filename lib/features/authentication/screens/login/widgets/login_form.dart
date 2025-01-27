import 'package:comro_alt/features/authentication/controllers/login/login_controller.dart';
import 'package:comro_alt/features/authentication/screens/password_config/forget_password.dart';
import 'package:comro_alt/features/authentication/screens/signup/signup.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/constants/text_strings.dart';
import 'package:comro_alt/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CLoginForm extends StatelessWidget {
  const CLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: CSizes.spaceBtwSections),
        child: Column(
          children: [
            //email
            TextFormField(
              controller: controller.email,
              validator: (value) => CValidators.validateEmail(value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: CText.email,
              ),
            ),
            const SizedBox(height: CSizes.spaceBtwInputFields),

            //password
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator: (value) => CValidators.validatePassword(value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.password_check),
                  labelText: CText.password,
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                    icon: Icon(
                      controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: CSizes.spaceBtwInputFields / 2),

            //remember me & forgot password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //remember me
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) => controller.rememberMe.value = !controller.rememberMe.value,
                      ),
                    ),
                    const Text(CText.rememberMe),
                  ],
                ),

                //forgot password
                TextButton(
                  onPressed: () => Get.to(() => const ForgetPassword()),
                  child: const Text(CText.forgetPassword),
                ),
              ],
            ),
            const SizedBox(height: CSizes.spaceBtwSections),

            //sign in button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.emailAndPasswordSignIn(),
                child: const Text(CText.signIn),
              ),
            ),
            const SizedBox(height: CSizes.spaceBtwInputFields),
            //sign up button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() => const SignUpScreen()),
                child: const Text(CText.signUp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
