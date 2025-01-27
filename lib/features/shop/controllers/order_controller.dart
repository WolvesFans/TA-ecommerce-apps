import 'package:comro_alt/common/widgets/success_screen/success_screen.dart';
import 'package:comro_alt/data/repositories/auth/auth_repository.dart';
import 'package:comro_alt/data/repositories/order/order_repository.dart';
import 'package:comro_alt/features/personalization/controllers/address_controller.dart';
import 'package:comro_alt/features/shop/controllers/cart_controller.dart';
import 'package:comro_alt/features/shop/controllers/checkout_controller.dart';
import 'package:comro_alt/features/shop/controllers/date_controller.dart';
import 'package:comro_alt/features/shop/models/order_model.dart';
import 'package:comro_alt/navigation_menu.dart';
import 'package:comro_alt/utils/constants/enums.dart';
import 'package:comro_alt/utils/constants/image_strings.dart';
import 'package:comro_alt/utils/popups/full_screen_loader.dart';
import 'package:comro_alt/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  //variables
  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final dateController = Get.put(DateController());
  final orderRepository = Get.put(OrderRepository());

  //fetch user's order history
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      CLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  //add method for order processing
  void processOrder(double totalAmount) async {
    try {
      //start loader
      CFullScreenLoader.openLoadingDialog('Processing your order', CImage.loadingAnimation);

      //get user auth id
      final userId = AuthRepository.instance.authUser!.uid;
      if (userId.isEmpty) return;

      //add details
      final order = OrderModel(
        id: UniqueKey().toString(),
        userId: userId,
        status: OrderStatus.pending,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        deliveryDateTime: dateController.deliveryDateTime.value!,
        items: cartController.cartItems.toList(),
      );

      //save order to firestore
      await orderRepository.saveOrder(order, userId);

      //update cart status
      cartController.clearCart();

      //show success screen
      Get.off(() => SuccessScreen(
            title: 'Payment Success',
            subtitle: 'Your item will be shipped soon',
            onPressed: () => Get.offAll(() => const NavigationMenu()),
          ));
    } catch (e) {
      CLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }
}
