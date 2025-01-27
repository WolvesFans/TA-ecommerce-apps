import 'package:comro_alt/data/repositories/user/user_repository.dart';
import 'package:comro_alt/features/authentication/screens/login/login.dart';
import 'package:comro_alt/features/authentication/screens/signup/verify_email.dart';
import 'package:comro_alt/navigation_menu.dart';
import 'package:comro_alt/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:comro_alt/utils/exceptions/firebase_exceptions.dart';
import 'package:comro_alt/utils/exceptions/format_exceptions.dart';
import 'package:comro_alt/utils/exceptions/platform_exceptions.dart';
import 'package:comro_alt/utils/local_storage/storage_utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository extends GetxController {
  static AuthRepository get instance => Get.find();

  //variable
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  //get authenticated user data
  User? get authUser => _auth.currentUser;

  //called from main.dart on app launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  //func to show relevant screen
  screenRedirect() async {
    final user = _auth.currentUser;

    if (user != null) {
      //if the user is logged in
      if (user.emailVerified) {
        //initialize user spesific storage
        await CLocalStorage.init(user.uid);

        //if the user's email verified, navigate to the main navigation menu
        Get.offAll(() => const NavigationMenu());
      } else {

        //if the user's email is not verified, navigate to the verifyemailscreen
        Get.offAll(
          () => VerifyEmailScreen(
            email: user.email,
          ),
        );
      }
    } else {
      //redirect to login screen
      Get.offAll(() => const LoginScreen());
    }
  }

  //[email auth] - register
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw CFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CFormatException();
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong :( Please try again.';
    }
  }

//[email auth] - sign in
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw CFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CFormatException();
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong :( Please try again.';
    }
  }

  //[email auth] - mail verif
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw CFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CFormatException();
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong :( Please try again.';
    }
  }

  //[email auth] - forget pass
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw CFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CFormatException();
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong :( Please try again.';
    }
  }

  //[reauth] - reauth user
  Future<void> reAuthWithEmailAndPassword(String email, String password) async {
    try {
      //create a credential
      AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);

      //reauth
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw CFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CFormatException();
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong :(';
    }
  }

  //[google auth] - google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      //trigger auth flow (pop up select account)
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      //obtain auth details from the request
      final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;

      //create new credential
      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      //return the credential
      return await _auth.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      throw CFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CFormatException();
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print('Something went wrong: $e');
      return null;
    }
  }

  //logout user
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw CFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CFormatException();
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong :(';
    }
  }

  //delete account
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw CFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CFormatException();
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong :(';
    }
  }
}
