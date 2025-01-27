import 'package:comro_alt/common/widgets/appbar/appbar.dart';
import 'package:comro_alt/features/personalization/controllers/user_controller.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/constants/text_strings.dart';
import 'package:comro_alt/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      appBar: const CAppBar(
        title: Text('Re-authenticate User'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Form(
            key: controller.reAuthFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //email
                TextFormField(
                  controller: controller.verifyEmail,
                  validator: (value) => CValidators.validateEmail(value),
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: CText.email,
                    prefixIcon: Icon(Iconsax.direct_right),
                  ),
                ),
                const SizedBox(height: CSizes.spaceBtwInputFields),

                //password
                Obx(
                  () => TextFormField(
                    controller: controller.verifyPassword,
                    validator: (value) => CValidators.validatePassword(value),
                    expands: false,
                    obscureText: controller.hidePassword.value,
                    decoration: InputDecoration(
                      labelText: CText.password,
                      prefixIcon: const Icon(Iconsax.password_check),
                      suffixIcon: IconButton(
                        onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                        icon: Icon(
                          controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: CSizes.spaceBtwSections),

                //verify button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.reAuthEmailAndPassword(),
                    child: const Text('Verify'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
