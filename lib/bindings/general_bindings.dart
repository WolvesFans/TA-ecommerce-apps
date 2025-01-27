import 'package:comro_alt/features/personalization/controllers/address_controller.dart';
import 'package:comro_alt/features/shop/controllers/cart_controller.dart';
import 'package:comro_alt/features/shop/controllers/checkout_controller.dart';
import 'package:comro_alt/features/shop/controllers/date_controller.dart';
import 'package:comro_alt/features/shop/controllers/order_controller.dart';
import 'package:comro_alt/features/shop/controllers/product_controller.dart';
import 'package:comro_alt/utils/helpers/network_manager.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(ProductController());
    Get.put(CartController());
    Get.put(AddressController());
    Get.put(CheckoutController());
    Get.put(OrderController());
    Get.put(DateController());
  }
}
