import 'package:comro_alt/common/widgets/texts/section_heading.dart';
import 'package:comro_alt/data/repositories/address/address_repository.dart';
import 'package:comro_alt/features/personalization/models/address_model.dart';
import 'package:comro_alt/features/personalization/screens/address/add_new_address.dart';
import 'package:comro_alt/features/personalization/screens/address/widgets/single_address.dart';
import 'package:comro_alt/utils/constants/image_strings.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/helpers/cloud_helper_functions.dart';
import 'package:comro_alt/utils/helpers/network_manager.dart';
import 'package:comro_alt/utils/popups/full_screen_loader.dart';
import 'package:comro_alt/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());

  //fetch all user spesific addresses
  Future<List<AddressModel>> getAllUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere((element) => element.selectedAddress, orElse: () => AddressModel.empty());
      return addresses;
    } catch (e) {
      CLoaders.errorSnackBar(
        title: 'Address not found',
        message: e.toString(),
      );
      return [];
    }
  }

  //select the used addresses
  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      //clear the selected field
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(selectedAddress.value.id, false);
      }

      //assign selected address
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      //set the "selected" field to true for the newly selected address
      await addressRepository.updateSelectedField(selectedAddress.value.id, true);
    } catch (e) {
      CLoaders.errorSnackBar(title: 'Error in selection', message: e.toString());
    }
  }

  //show addresses ModalBottomSheet at Checkout
  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        padding: const EdgeInsets.all(CSizes.sm),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: CSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CSectionHeading(title: 'Select Address'),
                  const SizedBox(height: CSizes.spaceBtwItems),
                  FutureBuilder(
                    future: getAllUserAddresses(),
                    builder: (_, snapshot) {
                      //helper function: handle loader, no record, or error message
                      final response = CCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                      if (response != null) return response;

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => CSingleAddress(
                          address: snapshot.data![index],
                          onTap: () async {
                            await selectAddress(snapshot.data![index]);
                            Get.back();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.to(() => const AddNewAddressScreen()),
                    child: const Text('Add new address'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  //add new address
  Future addNewAddresses() async {
    try {
      //start loading
      CFullScreenLoader.openLoadingDialog('Storing Address...', CImage.loadingAnimation);

      //check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        CFullScreenLoader.stopLoading();
        return;
      }

      //form validation
      if (!addressFormKey.currentState!.validate()) {
        CFullScreenLoader.stopLoading();
        return;
      }

      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        selectedAddress: false,
      );
      final id = await addressRepository.addAddress(address);

      //update selected address status
      address.id = id;
      await selectAddress(address);

      //remove loader
      CFullScreenLoader.stopLoading();

      //show success message
      CLoaders.successSnackBar(
        title: 'Congratulations!',
        message: 'Your address has been saved!',
      );

      //refresh addresses data
      refreshData.toggle();

      //reset fields
      resetFormFields();

      //redirect
      Navigator.of(Get.context!).pop();
    } catch (e) {
      //remove loaders
      CFullScreenLoader.stopLoading();
      CLoaders.errorSnackBar(
        title: 'Address not found',
        message: e.toString(),
      );
    }
  }

  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    city.clear();
    state.clear();
    postalCode.clear();
    addressFormKey.currentState?.reset();
  }
}
