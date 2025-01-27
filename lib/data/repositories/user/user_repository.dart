import 'dart:io';

import 'package:comro_alt/data/repositories/auth/auth_repository.dart';
import 'package:comro_alt/features/personalization/models/user_model.dart';
import 'package:comro_alt/utils/exceptions/firebase_exceptions.dart';
import 'package:comro_alt/utils/exceptions/format_exceptions.dart';
import 'package:comro_alt/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

//repository class for user-related operations
class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //function to save user data to Firestore
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection('Users').doc(user.id).set(user.toJson());
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

  //function to fetch user details based on uid
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db.collection('Users').doc(AuthRepository.instance.authUser?.uid).get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
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

  //function to update user data in firestore
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db.collection("Users").doc(updatedUser.id).update(updatedUser.toJson());
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

  //update any fields in spesific users collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db.collection("Users").doc(AuthRepository.instance.authUser?.uid).update(json);
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

  //function to remove user data from firestore
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection("Users").doc(userId).delete();
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

  //upload any images
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
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
