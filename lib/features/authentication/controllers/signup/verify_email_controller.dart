import 'dart:async';

import 'package:comro_alt/common/widgets/success_screen/success_screen.dart';
import 'package:comro_alt/data/repositories/auth/auth_repository.dart';
import 'package:comro_alt/utils/constants/text_strings.dart';
import 'package:comro_alt/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  //send email whenever verify screen appears & set timer for auto redirect
  @override
  void onInit() {
    sendEmailVerification();
    setAutoRedirectTimer();
    super.onInit();
  }

  //send email verif link
  sendEmailVerification() async {
    try {
      await AuthRepository.instance.sendEmailVerification();
      CLoaders.successSnackBar(title: 'Email sent', message: 'Please check your email and verify your email.');
    } catch (e) {
      CLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }

  //timer to automatically redirect on email verif
  setAutoRedirectTimer() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        await FirebaseAuth.instance.currentUser?.reload();
        final user = FirebaseAuth.instance.currentUser;
        if (user?.emailVerified ?? false) {
          timer.cancel();
          Get.off(
            () => SuccessScreen(
              title: CText.yourAccountCreatedTitle,
              subtitle: CText.yourAccountCreatedSubtitle,
              onPressed: () => AuthRepository.instance.screenRedirect(),
            ),
          );
        }
      },
    );
  }

  //manually check if email verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(
        () => SuccessScreen(
          title: CText.yourAccountCreatedTitle,
          subtitle: CText.yourAccountCreatedSubtitle,
          onPressed: () => AuthRepository.instance.screenRedirect(),
        ),
      );
    }
  }
}
