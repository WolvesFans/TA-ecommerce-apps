import 'package:comro_alt/common/widgets/success_screen/success_screen.dart';
import 'package:comro_alt/data/repositories/auth/auth_repository.dart';
import 'package:comro_alt/data/repositories/order/alt_order_repository.dart';
import 'package:comro_alt/features/personalization/controllers/address_controller.dart';
import 'package:comro_alt/features/shop/controllers/cart_controller.dart';
import 'package:comro_alt/features/shop/controllers/checkout_controller.dart';
import 'package:comro_alt/features/shop/controllers/date_controller.dart';
import 'package:comro_alt/features/shop/models/alt_order_model.dart';
import 'package:comro_alt/navigation_menu.dart';
import 'package:comro_alt/utils/constants/enums.dart';
import 'package:comro_alt/utils/constants/image_strings.dart';
import 'package:comro_alt/utils/popups/full_screen_loader.dart';
import 'package:comro_alt/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AltOrderController extends GetxController {
  static AltOrderController get instance => Get.find();

  //variables
  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final dateController = Get.put(DateController());
  final altOrderRepository = Get.put(AltOrderRepository());

  //fetch user's order history
  Future<List<AltOrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await altOrderRepository.fetchUserOrders();
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
      final order = AltOrderModel(
        id: UniqueKey().toString(),
        userId: userId,
        status: OrderStatus.pending,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        deliveryMonth: DateFormat('MMMM').format(dateController.deliveryDateTime.value!),
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        deliveryDateTime: dateController.deliveryDateTime.value!,
        items: cartController.cartItems.toList(),
      );

      //save order to firestore
      await altOrderRepository.saveOrder(order);

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
