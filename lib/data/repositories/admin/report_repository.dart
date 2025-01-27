import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comro_alt/features/shop/models/alt_order_model.dart';
import 'package:comro_alt/features/shop/models/product_model.dart';
import 'package:get/get.dart';

class ReportRepository extends GetxController {
  static ReportRepository get instance => Get.find();

  //firestore instance for database iterations
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // function to fetch order details
  Future<List<AltOrderModel>> fetchOrders() async {
    try {
      final snapshot = await _db.collection('Orders').get();
      return snapshot.docs.map((e) => AltOrderModel.fromSnapshot(e)).toList();
    } catch (e) {
      print(e.toString());
      throw 'Something went wrong while fetching orders. Try again later.';
    }
  }

  //test
  // Future<List<AltOrderModel>> fetchOrders() async {
  //   try {
  //     final result = await _db.collection('Orders').get();
  //     print(result.docs);
  //     return result.docs.map((documentSnapshot) => AltOrderModel.fromDocumentSnapshot(documentSnapshot)).toList();
  //   } catch (e) {
  //     print(e.toString());
  //     // throw 'Something went wrong while fetching products. Try again later.';
  //     throw e.toString();
  //   }
  // }
}
