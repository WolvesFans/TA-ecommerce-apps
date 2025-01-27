import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comro_alt/data/repositories/auth/auth_repository.dart';
import 'package:comro_alt/features/shop/models/order_model.dart';
import 'package:get/get.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  //variables
  final _db = FirebaseFirestore.instance;

  //get all order related to user

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userId = AuthRepository.instance.authUser!.uid;
      if (userId.isEmpty) throw 'Unable to find user information. Try again later';
      print('user id: $userId');

      final result = await _db.collection('Users').doc(userId).collection('Orders').get();
      print('fetched ${result.docs.length} orders');
      return result.docs.map((documentSnapshot) => OrderModel.fromSnapshot(documentSnapshot)).toList();
    } catch (e) {
      throw 'Something went wrong while fetching order information. Try again later.';
    }
  }

  //store new user order
  Future<void> saveOrder(OrderModel order, String userId) async {
    try {
      await _db.collection('Users').doc(userId).collection('Orders').add(order.toJson());
    } catch (e) {
      throw 'Something went wrong while saving order information. Try again later.';
    }
  }
}
