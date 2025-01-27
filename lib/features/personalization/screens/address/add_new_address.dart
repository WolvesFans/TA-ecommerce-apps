import 'package:comro_alt/common/widgets/appbar/appbar.dart';
import 'package:comro_alt/features/personalization/controllers/address_controller.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Scaffold(
      appBar: CAppBar(
        showBackArrow: true,
        title: Text(
          'Add New Address',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Form(
            key: controller.addressFormKey,
            child: Column(
              children: [
                //name
                TextFormField(
                  controller: controller.name,
                  validator: (value) => CValidators.validateEmptyText('Name', value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: 'Name',
                  ),
                ),
                const SizedBox(height: CSizes.spaceBtwInputFields),

                //phone number
                TextFormField(
                  controller: controller.phoneNumber,
                  validator: (value) => CValidators.validatePhoneNumber(value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.mobile),
                    labelText: 'Phone Number',
                  ),
                ),
                const SizedBox(height: CSizes.spaceBtwInputFields),

                //street
                TextFormField(
                  controller: controller.street,
                  validator: (value) => CValidators.validateEmptyText('Street', value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.building_31),
                    labelText: 'Street',
                  ),
                ),
                const SizedBox(height: CSizes.spaceBtwInputFields),

                //postal code
                TextFormField(
                  controller: controller.postalCode,
                  validator: (value) => CValidators.validateEmptyText('Postal Code', value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.code),
                    labelText: 'Postal Code',
                  ),
                ),
                const SizedBox(height: CSizes.spaceBtwInputFields),

                //city
                TextFormField(
                  controller: controller.city,
                  validator: (value) => CValidators.validateEmptyText('City', value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.building),
                    labelText: 'City',
                  ),
                ),
                const SizedBox(height: CSizes.spaceBtwInputFields),

                //state
                TextFormField(
                  controller: controller.state,
                  validator: (value) => CValidators.validateEmptyText('State', value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.activity),
                    labelText: 'State',
                  ),
                ),
                const SizedBox(height: CSizes.spaceBtwInputFields),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(CSizes.defaultSpace / 2),
        child: ElevatedButton(
          onPressed: () async {
            controller.addNewAddresses();
          },
          child: const Text('Add New Address'),
        ),
      ),
    );
  }
}
