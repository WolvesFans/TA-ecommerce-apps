import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comro_alt/features/shop/models/product_model.dart';
import 'package:comro_alt/utils/exceptions/firebase_exceptions.dart';
import 'package:comro_alt/utils/exceptions/format_exceptions.dart';
import 'package:comro_alt/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

//repository for managing product-related data and operations
class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  //firestore instance for database iterations
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //function to save product data to firestore
  Future<void> saveProductRecord(ProductModel product) async {
    try {
      await _db.collection('Products').add(product.toJson());
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

  //function to fetch product details based on user ID
  Future<ProductModel> fetchProductDetails() async {
    try {
      final documentSnapshot = await _db.collection("Product").doc().get();
      if (documentSnapshot.exists) {
        return ProductModel.fromSnapshot(documentSnapshot);
      } else {
        return ProductModel.empty();
      }
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const CFormatException();
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    }
  }

  //update any fields in spesific users collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db.collection("Products").doc().update(json);
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

  //function to fetch ala carte product details based on uid
  Future<List<ProductModel>> getAlaCarteProducts() async {
    try {
      final snapshot = await _db.collection('Products').where('Categories', isEqualTo: 'Ala Carte').get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
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

  // //function to fetch bundle product details based on uid
  Future<List<ProductModel>> getBundleProducts() async {
    try {
      final snapshot = await _db.collection('Products').where('Categories', isEqualTo: 'Bundle').get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
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

  //function to fetch all product by categories
  Future<List<ProductModel>> getProduct(String categories) async {
    try {
      final snapshot = await _db.collection('Products').where('Categories', isEqualTo: categories).get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).toString();
    } on FormatException catch (_) {
      throw const CFormatException();
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).toString();
    } catch (e) {
      throw 'Something went wrong :(';
    }
  }

  // //function to fetch bundle product details based on uid
  // Future<List<ProductModel>> getBundleProduct() async {
  //   try {
  //     final snapshot = await _db.collection('Products').where('Bundle', isEqualTo: true).get();
  //     return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
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

  // //function to fetch beverages product details based on uid
  // Future<List<ProductModel>> getBeveragesProduct() async {
  //   try {
  //     final snapshot = await _db.collection('Products').where('Beverages', isEqualTo: true).get();
  //     return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
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

  //upload any images
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;

      //
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
