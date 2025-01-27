import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comro_alt/features/personalization/models/address_model.dart';
import 'package:comro_alt/features/shop/models/cart_item_model.dart';
import 'package:comro_alt/utils/constants/enums.dart';
import 'package:comro_alt/utils/helpers/helper_functions.dart';

class OrderModel {
  final String id;
  final String userId;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel address;
  final DateTime deliveryDateTime;
  final List<CartItemModel> items;

  OrderModel({
    required this.id,
    this.userId = '',
    required this.status,
    required this.items,
    required this.totalAmount,
    required this.orderDate,
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
      'paymentMethod': paymentMethod,
      'address': address.toJson(), //addressmodel to map
      'deliveryDate': deliveryDateTime,
      'items': items.map((item) => item.toJson()).toList(), //cartmodel to map
    };
  }
   

  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return OrderModel(
      id: data['id'] as String,
      userId: data['userId'] as String,
      status: OrderStatus.values.firstWhere((e) => e.toString() == data['status']),
      totalAmount: data['totalAmount'] as double,
      orderDate: (data['orderDate'] as Timestamp).toDate(),
      paymentMethod: data['paymentMethod'] as String,
      address: AddressModel.fromMap(data['address'] as Map<String, dynamic>),
      deliveryDateTime: (data['deliveryDate'] as Timestamp).toDate(),
      items: (data['items'] as List<dynamic>).map((itemData) => CartItemModel.fromJson(itemData as Map<String, dynamic>)).toList(),
    );
  }
}
