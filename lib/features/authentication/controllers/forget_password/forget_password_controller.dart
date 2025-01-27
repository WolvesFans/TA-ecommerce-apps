import 'package:comro_alt/data/repositories/auth/auth_repository.dart';
import 'package:comro_alt/features/authentication/screens/password_config/reset_password.dart';
import 'package:comro_alt/utils/constants/image_strings.dart';
import 'package:comro_alt/utils/helpers/network_manager.dart';
import 'package:comro_alt/utils/popups/full_screen_loader.dart';
import 'package:comro_alt/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  //variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  //send reset password email
  sendPasswordResetEmail() async {
    try {
      //start loading
      CFullScreenLoader.openLoadingDialog('Processing your request..', CImage.loadingAnimation);

      //check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        CFullScreenLoader.stopLoading();
        return;
      }

      //form validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        CFullScreenLoader.stopLoading();
        return;
      }

      //send reset password email
      await AuthRepository.instance.sendPasswordResetEmail(email.text.trim());

      //remove loader
      CFullScreenLoader.stopLoading();

      //show success snackbar
      CLoaders.successSnackBar(
        title: 'Email sent!',
        message: 'Check your password reset link in your email.',
      );

      //redirect
      Get.to(
        () => ResetPasswordScreen(
          email: email.text.trim(),
        ),
      );
    } catch (e) {
      //remove loaders
      CFullScreenLoader.stopLoading();
      CLoaders.errorSnackBar(
        title: 'Oh snap',
        message: e.toString(),
      );
    }
  }

  //resend reset password email
  resendPasswordResetEmail(String email) async {
    try {
      //start loading
      CFullScreenLoader.openLoadingDialog('Processing your request...', CImage.loadingAnimation);

      //check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        CFullScreenLoader.stopLoading();
        return;
      }

      //resend reset password email
      await AuthRepository.instance.sendPasswordResetEmail(email);

      //remove loader
      CFullScreenLoader.stopLoading();

      //show success snackbar
      CLoaders.successSnackBar(
        title: 'Email sent!',
        message: 'Check your password reset link in your email.',
      );
    } catch (e) {
      CFullScreenLoader.stopLoading();
      CLoaders.errorSnackBar(
        title: 'Oh snap!',
        message: e.toString(),
      );
    }
  }
}
