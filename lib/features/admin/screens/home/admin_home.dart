import 'package:comro_alt/common/widgets/appbar/appbar.dart';
import 'package:comro_alt/features/admin/screens/home/widgets/admin_container.dart';
import 'package:comro_alt/features/admin/screens/input_product/admin_input_product.dart';
import 'package:comro_alt/features/admin/screens/report/admin_report.dart';
import 'package:comro_alt/features/shop/controllers/product_controller.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(ProductController());
    return Scaffold(
      appBar: CAppBar(
        title: Text(
          'Admin Dashboard',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            children: [
              //input product
              AdminContainer(
                icon: Iconsax.document_upload,
                text: 'Input Product',
                onTap: () => Get.to(() => AdminInputProduct()),
              ),
              const SizedBox(height: CSizes.spaceBtwItems),

              //view, edit, delete product
              // AdminContainer(
              //   icon: Iconsax.document,
              //   text: 'View Product',
              //   onTap: () => Get.to(() => AdminViewProduct(product: ProductModel.empty())),
              // ),
              // const SizedBox(height: CSizes.spaceBtwItems),

              //order list
              // AdminContainer(
              //   icon: Iconsax.task,
              //   text: 'Order List',
              //   onTap: () => Get.to(() => const AdminOrderList()),
              // ),

              //data download
              AdminContainer(
                icon: Iconsax.document,
                text: 'Report',
                onTap: () => Get.to(() => AdminReport()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
