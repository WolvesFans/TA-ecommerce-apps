import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comro_alt/data/repositories/auth/auth_repository.dart';
import 'package:comro_alt/features/shop/models/alt_order_model.dart';
import 'package:comro_alt/utils/exceptions/firebase_exceptions.dart';
import 'package:comro_alt/utils/exceptions/format_exceptions.dart';
import 'package:comro_alt/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AltOrderRepository extends GetxController {
  static AltOrderRepository get instance => Get.find();

  //variables
  final _db = FirebaseFirestore.instance;
  // final DateTime? orderDate = DateController.instance.deliveryDateTime.value;

  //get all order related to user

  Future<List<AltOrderModel>> fetchUserOrders() async {
    try {
      final userId = AuthRepository.instance.authUser!.uid;
      if (userId.isEmpty) throw 'Unable to find user information. Try again later';
      print('user id: $userId');

      final result = await _db.collection('Users').doc().collection('Orders').get();
      print('fetched ${result.docs.length} orders');
      return result.docs.map((documentSnapshot) => AltOrderModel.fromSnapshot(documentSnapshot)).toList();
    } catch (e) {
      throw 'Something went wrong while fetching order information. Try again later.';
    }
  }

  //store new user order
  Future<void> saveOrder(AltOrderModel order) async {
    try {
      //store order
      await _db.collection('Orders').add(order.toJson());
    } catch (e) {
      throw 'Something went wrong while saving order information. Try again later.';
    }
  }

  //upload transfer receipt images
  // Future<String> uploadImage(String path, XFile image) async {
  //   try {
  //     final ref = FirebaseStorage.instance.ref(path).child(image.name);
  //     await ref.putFile(File(image.path));
  //     final url = await ref.getDownloadURL();
  //     return url;
  //   } on FirebaseException catch (e) {
  //     throw CFirebaseException(e.code).message;
  //   } on FormatException catch (_) {
  //     throw const CFormatException();
  //   } on PlatformException catch (e) {
  //     throw CPlatformException(e.code).message;
  //   } catch (e) {
  //     throw 'Something went wrong :(';
  //   }
  // }

  //test upload transfer receipt images
  Future<String> uploadImage(String path, File image) async {
    //generate unique file name
    String fileName = DateFormat('E, dd MMM yyy - HH.mm').format(DateTime.now());

    //reference to the file in firebase storage
    Reference ref = FirebaseStorage.instance.ref(path).child(fileName);

    //upload file to firebase storage
    UploadTask uploadImage = ref.putFile(image);

    //wait for the upload to complete
    TaskSnapshot taskSnapshot = await uploadImage.whenComplete(() => null);

    //get the download url
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    return downloadUrl;
  }
}
