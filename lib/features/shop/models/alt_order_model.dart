import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comro_alt/features/personalization/models/address_model.dart';
import 'package:comro_alt/features/shop/models/cart_item_model.dart';
import 'package:comro_alt/utils/constants/enums.dart';
import 'package:comro_alt/utils/helpers/helper_functions.dart';
import 'package:intl/intl.dart';

class AltOrderModel {
  final String id;
  final String userId;
  final String deliveryMonth;
  final String paymentMethod;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final AddressModel address;
  final DateTime deliveryDateTime;
  final List<CartItemModel> items;

  AltOrderModel({
    required this.id,
    this.userId = '',
    required this.status,
    required this.items,
    required this.totalAmount,
    required this.orderDate,
    required this.deliveryMonth,
    this.paymentMethod = 'GoPay',
    required this.address,
    required this.deliveryDateTime,
  });

  String get formattedOrderDate => CHelperFunctions.getFormattedDate(orderDate);

  String get formattedDeliveryDate => CHelperFunctions.getFormattedDate(deliveryDateTime);

  String get orderStatusText => status == OrderStatus.delivered
      ? 'Delivered'
      : status == OrderStatus.shipped
          ? 'Shipped'
          : 'Processing';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status.toString(), //enum to string
      'totalAmount': totalAmount,
      'orderDate': orderDate,
      'deliveryMonth': deliveryMonth,
      'paymentMethod': paymentMethod,
      'address': address.toJson(), //addressmodel to map
      'deliveryDate': deliveryDateTime,
      'items': items.map((item) => item.toJson()).toList(), //cartmodel to map
    };
  }

  // factory AltOrderModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
  //   final data = snapshot.data()! as Map<String, dynamic>;
  //   return AltOrderModel(
  //     id: data['id'] as String,
  //     userId: data['userId'] as String,
  //     status: OrderStatus.values.firstWhere((e) => e.toString() == data['status']),
  //     totalAmount: data['totalAmount'] as double,
  //     orderDate: (data['orderDate'] as Timestamp).toDate(),
  //     deliveryMonth: (data['deliveryMonth'] as Timestamp).toDate().month.toString(),
  //     paymentMethod: data['paymentMethod'] as String,
  //     address: AddressModel.fromMap(data['address'] as Map<String, dynamic>),
  //     deliveryDateTime: (data['deliveryDate'] as Timestamp).toDate(),
  //     items: (data['items'] as List<dynamic>).map((itemData) => CartItemModel.fromJson(itemData as Map<String, dynamic>)).toList(),
  //   );
  // }

  factory AltOrderModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return AltOrderModel(
      id: document.id,
      status: OrderStatus.values.firstWhere((e) => e.toString() == data['status']),
      items: (data['items'] as List<dynamic>).map((itemData) => CartItemModel.fromJson(itemData as Map<String, dynamic>)).toList(),
      totalAmount: double.parse((data['totalAmount'] ?? 0.0).toString()),
      orderDate: (data['orderDate'] as Timestamp).toDate(),
      deliveryMonth: data['deliveryMonth'].toString(),
      address: AddressModel.fromMap(data['address'] as Map<String, dynamic>),
      deliveryDateTime: (data['deliveryDate'] as Timestamp).toDate(),
    );
  }

  // factory AltOrderModel.fromMap(Map<String, dynamic> data) {
  //   return AltOrderModel(
  //     id: data['id'] as String,
  //     status: OrderStatus.values.firstWhere((e) => e.toString() == data['status']),
  //     items: (data['items'] as List<dynamic>).map((itemData) => CartItemModel.fromJson(itemData as Map<String, dynamic>)).toList(),
  //     totalAmount: data['totalAmount'] as double,
  //     orderDate: (data['orderDate'] as Timestamp).toDate(),
  //     deliveryMonth: (data['deliveryMonth'] as Timestamp).toDate().month.toString(),
  //     address: AddressModel.fromMap(data['address'] as Map<String, dynamic>),
  //     deliveryDateTime: (data['deliveryDate'] as Timestamp).toDate(),
  //   );
  // }
}
