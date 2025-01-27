import 'package:comro_alt/common/widgets/appbar/appbar.dart';
import 'package:comro_alt/features/personalization/controllers/update_name_controller.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/constants/text_strings.dart';
import 'package:comro_alt/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      //custom appbar
      appBar: CAppBar(
        showBackArrow: true,
        title: Text(
          'Change Name',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(CSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //text field and button
            Form(
              key: controller.updateNameFormKey,
              child: Column(
                children: [
                  //first name
                  TextFormField(
                    controller: controller.firstName,
                    validator: (value) => CValidators.validateEmptyText('First Name', value),
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: CText.firstName,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                  const SizedBox(height: CSizes.spaceBtwInputFields),
                  //last name
                  TextFormField(
                    controller: controller.lastName,
                    validator: (value) => CValidators.validateEmptyText('Last name', value),
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: CText.lastName,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: CSizes.spaceBtwSections),

            //save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateUserName(),
                child: const Text('Save'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
