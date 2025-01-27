import 'package:comro_alt/data/repositories/auth/auth_repository.dart';
import 'package:comro_alt/data/repositories/user/user_repository.dart';
import 'package:comro_alt/features/authentication/screens/signup/verify_email.dart';
import 'package:comro_alt/features/personalization/models/user_model.dart';
import 'package:comro_alt/utils/constants/image_strings.dart';
import 'package:comro_alt/utils/helpers/network_manager.dart';
import 'package:comro_alt/utils/popups/full_screen_loader.dart';
import 'package:comro_alt/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  ///variables
  final hidePassword = true.obs; //observe for hiding/showing password
  final firstName = TextEditingController(); //controller for first name
  final lastName = TextEditingController(); //controller for last name
  final username = TextEditingController(); //controller for username
  final email = TextEditingController(); //controller for email
  final password = TextEditingController(); //controller for password
  final phoneNumber = TextEditingController(); // controller for phone number
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>(); //form key for validation

  //signup
  void signup() async {
    try {
      //start loading
      CFullScreenLoader.openLoadingDialog('Processing your information', CImage.loadingAnimation);

      //check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //remove loader
        CFullScreenLoader.stopLoading();
        return;
      }

      //form validation
      if (!signupFormKey.currentState!.validate()) {
        //remove loader
        CFullScreenLoader.stopLoading();
        return;
      }

      //register user in Firebase Authentication & save user data in the Firebase
      final userCredential = await AuthRepository.instance.registerWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      //save authenticated user data in the Firebase Firestore. tanya ke gemini
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      //remove loader 
      CFullScreenLoader.stopLoading();

      //Show success message
      CLoaders.successSnackBar(title: 'Congrats!', message: 'Your account has been created! Verify your email to continue.');

      //move to verify email screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      //remove loader
      CFullScreenLoader.stopLoading();

      //show generic error to user
      CLoaders.errorSnackBar(
        title: 'Oops!',
        message: e.toString(),
      );
    }
  }
}
