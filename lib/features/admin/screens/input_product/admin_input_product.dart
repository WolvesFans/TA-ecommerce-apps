import 'dart:core';
import 'package:comro_alt/common/widgets/appbar/appbar.dart';
import 'package:comro_alt/features/admin/screens/home/widgets/admin_add_image.dart';
import 'package:comro_alt/features/admin/controllers/input_product_controller.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/constants/text_strings.dart';
import 'package:comro_alt/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminInputProduct extends StatefulWidget {
  const AdminInputProduct({super.key});

  @override
  State<AdminInputProduct> createState() => _AdminInputProductState();
}

class _AdminInputProductState extends State<AdminInputProduct> {
  String selectedCategory = '';
  String image = '';

  final controller = Get.put(InputProductController());

  @override
  void dispose() {
    controller.title.dispose();
    controller.description.dispose();
    controller.price.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //tombol input product
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(CSizes.defaultSpace / 2),
        child: ElevatedButton(
          onPressed: () async {
            controller.inputProduct();
          },
          child: const Text('Input Product'),
        ),
      ),

      // appbar
      appBar: CAppBar(
        showBackArrow: true,
        title: Text(
          'Input Product',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),

      //isi halaman
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Form(
            key: controller.inputProductFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //image
                Text(
                  'Image',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: CSizes.sm),
                const AdminAddImage(),
                const SizedBox(height: CSizes.spaceBtwItems),

                //product name
                Text(
                  'Product Name',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: CSizes.sm),
                TextFormField(
                  controller: controller.title,
                  validator: (value) => CValidators.validateEmptyText('Title', value),
                  decoration: const InputDecoration(
                    labelText: 'Product Name',
                  ),
                ),
                const SizedBox(height: CSizes.spaceBtwItems * 2),

                //description
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: CSizes.sm),
                TextFormField(
                  validator: (value) => CValidators.validateEmptyText('Description', value),
                  controller: controller.description,
                  minLines: 3,
                  maxLines: 6,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                ),
                const SizedBox(height: CSizes.spaceBtwItems * 2),

                //price
                Text(
                  'Price',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: CSizes.sm),
                TextFormField(
                  validator: (value) => CValidators.validateEmptyText('Price', value),
                  controller: controller.price,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                  ),
                ),
                const SizedBox(height: CSizes.spaceBtwItems * 2),

                //categories
                Text(
                  'Categories',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: CSizes.sm),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      RadioListTile(
                        title: const Text(CText.alaCarte),
                        value: 'Ala Carte',
                        groupValue: selectedCategory,
                        onChanged: (String? newSelection) {
                          setState(() {
                            selectedCategory = newSelection!;
                          });
                          controller.updateSelectedCategory(newSelection!);
                        },
                      ),
                      RadioListTile(
                        title: const Text(CText.bundle),
                        value: 'Bundle',
                        groupValue: selectedCategory,
                        onChanged: (String? newSelection) {
                          setState(() {
                            selectedCategory = newSelection!;
                          });
                          controller.updateSelectedCategory(newSelection!);
                        },
                      ),
                      RadioListTile(
                        title: const Text(CText.beverages),
                        value: 'Beverages',
                        groupValue: selectedCategory,
                        onChanged: (String? newSelection) {
                          setState(() {
                            selectedCategory = newSelection!;
                          });
                          controller.updateSelectedCategory(newSelection!);
                        },
                      ),
                    ],
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
