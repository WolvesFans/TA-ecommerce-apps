import 'package:comro_alt/data/repositories/auth/auth_repository.dart';
import 'package:comro_alt/features/personalization/controllers/user_controller.dart';
import 'package:comro_alt/utils/constants/image_strings.dart';
import 'package:comro_alt/utils/helpers/network_manager.dart';
import 'package:comro_alt/utils/popups/full_screen_loader.dart';
import 'package:comro_alt/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  //variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  //email and password sign in
  Future<void> emailAndPasswordSignIn() async {
    try {
      //start loading
      CFullScreenLoader.openLoadingDialog('Logging you in...', CImage.loadingAnimation);

      //check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        CFullScreenLoader.stopLoading();
        return;
      }

      //form validation
      if (!loginFormKey.currentState!.validate()) {
        CFullScreenLoader.stopLoading();
        return;
      }

      //save data if remember me is selected
      if (rememberMe.value = true) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      //login user using email and password auth
      // ignore: unused_local_variable
      final userCredentials = await AuthRepository.instance.signInWithEmailAndPassword(email.text.trim(), password.text.trim());

      //remove loader
      CFullScreenLoader.stopLoading();

      //redirect
      AuthRepository.instance.screenRedirect();
    } catch (e) {
      CFullScreenLoader.stopLoading();
      CLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }

  //google sign in auth
  Future<void> googleSignIn() async {
    try {
      //start loading
      CFullScreenLoader.openLoadingDialog('Logging you in...', CImage.loadingAnimation);

      //check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //remove loader
        CFullScreenLoader.stopLoading();
        return;
      }

      //google auth
      final userCredentials = await AuthRepository.instance.signInWithGoogle();

      //save user record
      await userController.saveUserRecord(userCredentials);

      //remove loader
      CFullScreenLoader.stopLoading();

      //redirect
      AuthRepository.instance.screenRedirect();
    } catch (e) {
      CLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }
}
