import 'package:comro_alt/data/repositories/auth/auth_repository.dart';
import 'package:comro_alt/data/repositories/user/user_repository.dart';
import 'package:comro_alt/features/authentication/screens/login/login.dart';
import 'package:comro_alt/features/personalization/screens/profile/widgets/reauth_user_login_form.dart';
import 'package:comro_alt/features/personalization/models/user_model.dart';
import 'package:comro_alt/utils/constants/image_strings.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/helpers/network_manager.dart';
import 'package:comro_alt/utils/popups/full_screen_loader.dart';
import 'package:comro_alt/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final imageUploading = false.obs;
  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  //fetch user record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  //save user record from any registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      //update rx user and then check if user data is already stored. if not, store new data
      await fetchUserRecord();

      //if no record already stored
      if (user.value.id.isEmpty) {
        if (userCredentials != null) {
          //convert name to first name and last name
          final nameParts = UserModel.nameParts(userCredentials.user!.displayName ?? '');
          final username = UserModel.generateUsername(userCredentials.user!.displayName ?? '');

          //map data
          final user = UserModel(
            id: userCredentials.user!.uid,
            firstName: nameParts[0],
            lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : "",
            username: username,
            email: userCredentials.user!.email ?? '',
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '',
          );

          //save user data
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      CLoaders.warningSnackBar(
        title: 'Data not saved',
        message: 'Something went wrong while saving your information.',
      );
    }
  }

  //delete account warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(CSizes.md),
      title: 'Delete Accout',
      middleText: 'Are you sure want to delete your account permanently?',
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: CSizes.lg),
          child: Text('Delete'),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Text('Cancel'),
      ),
    );
  }

  //delete user accunt
  void deleteUserAccount() async {
    try {
      CFullScreenLoader.openLoadingDialog('Processing...', CImage.loadingAnimation);

      //first reauth user
      final auth = AuthRepository.instance;
      final provider = auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        //re verif auth email
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          CFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          CFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      CFullScreenLoader.stopLoading();
      CLoaders.warningSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }

  //reauth before deleting
  Future<void> reAuthEmailAndPassword() async {
    try {
      CFullScreenLoader.openLoadingDialog('Processing..', CImage.loadingAnimation);

      //check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        CFullScreenLoader.stopLoading();
        return;
      }

      //form validation
      if (!reAuthFormKey.currentState!.validate()) {
        CFullScreenLoader.stopLoading();
        return;
      }

      //
      await AuthRepository.instance.reAuthWithEmailAndPassword(verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthRepository.instance.deleteAccount();
      CFullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      CFullScreenLoader.stopLoading();
      CLoaders.warningSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }

  //upload profile image
  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );
      if (image != null) {
        imageUploading.value = true;
        //upload image
        final imageUrl = await userRepository.uploadImage('Users/Images/Profile', image);

        //update user image record
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;
        user.refresh();
        CLoaders.successSnackBar(title: 'Congrats!', message: 'Your profile picture has been updated!');
      }
    } catch (e) {
      CLoaders.errorSnackBar(title: 'Oh snap!', message: 'Something went wrong: $e');
    } finally {
      imageUploading.value = false;
    }
  }
}
