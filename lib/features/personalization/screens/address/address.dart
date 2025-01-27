// ignore: unused_import
import 'dart:ffi';

import 'package:comro_alt/common/widgets/appbar/appbar.dart';
import 'package:comro_alt/features/personalization/controllers/address_controller.dart';
import 'package:comro_alt/features/personalization/screens/address/add_new_address.dart';
import 'package:comro_alt/features/personalization/screens/address/widgets/single_address.dart';
import 'package:comro_alt/utils/constants/colors.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UserAddressScreen extends StatefulWidget {
  const UserAddressScreen({super.key});

  @override
  State<UserAddressScreen> createState() => _UserAddressScreenState();
}

class _UserAddressScreenState extends State<UserAddressScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: CColors.primary,
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        child: const Icon(
          Iconsax.add,
          color: CColors.white,
        ),
      ),
      appBar: CAppBar(
        showBackArrow: true,
        title: Text(
          'Addresses',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Obx(
            () => FutureBuilder(
                //use key to trigger refresh
                key: Key(controller.refreshData.value.toString()),
                future: controller.getAllUserAddresses(),
                builder: (context, snapshot) {
                  //helper function: handle loader, no record, or error message
                  final response = CCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                  if (response != null) return response;

                  final addresses = snapshot.data!;

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: addresses.length,
                    itemBuilder: (_, index) => CSingleAddress(
                      address: addresses[index],
                      onTap: () => controller.selectAddress(addresses[index]),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
