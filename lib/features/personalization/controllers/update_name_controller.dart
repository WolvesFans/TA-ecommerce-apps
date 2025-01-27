import 'package:comro_alt/data/repositories/user/user_repository.dart';
import 'package:comro_alt/features/personalization/controllers/user_controller.dart';
import 'package:comro_alt/features/personalization/screens/settings/settings.dart';
import 'package:comro_alt/utils/constants/image_strings.dart';
import 'package:comro_alt/utils/helpers/network_manager.dart';
import 'package:comro_alt/utils/popups/full_screen_loader.dart';
import 'package:comro_alt/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//controller to update user-related functionality
class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateNameFormKey = GlobalKey<FormState>();

  //init user data when home screen appears
  @override
  void onInit() {
    initializeName();
    super.onInit();
  }

  //fetch user record
  Future<void> initializeName() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      //start loading
      CFullScreenLoader.openLoadingDialog('Loading your information..', CImage.loadingAnimation);

      //check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        CFullScreenLoader.stopLoading();
        return;
      }

      //form validation
      if (!updateNameFormKey.currentState!.validate()) {
        CFullScreenLoader.stopLoading();
        return;
      }

      //update user first & last name in the firebase firestore
      Map<String, dynamic> name = {
        'FirstName': firstName.text.trim(),
        'LastName': lastName.text.trim(),
      };
      await userRepository.updateSingleField(name);

      //update the rx value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      //remove loader
      CFullScreenLoader.stopLoading();

      //show success message
      CLoaders.successSnackBar(title: 'Congrats!', message: 'Your name has been updated');

      //back to previous page
      Get.off(() => const SettingsScreen());
    } catch (e) {
      CFullScreenLoader.stopLoading();
      CLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }
}
