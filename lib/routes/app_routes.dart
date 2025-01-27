import 'package:comro_alt/features/authentication/screens/login/login.dart';
import 'package:comro_alt/features/authentication/screens/password_config/forget_password.dart';
import 'package:comro_alt/features/authentication/screens/signup/signup.dart';
import 'package:comro_alt/features/authentication/screens/signup/verify_email.dart';
import 'package:comro_alt/features/personalization/screens/address/address.dart';
import 'package:comro_alt/features/personalization/screens/profile/profile.dart';
import 'package:comro_alt/features/personalization/screens/settings/settings.dart';
import 'package:comro_alt/features/shop/screens/cart/cart.dart';
import 'package:comro_alt/features/shop/screens/checkout/checkout.dart';
import 'package:comro_alt/features/shop/screens/home/home.dart';
import 'package:comro_alt/features/shop/screens/order/order.dart';
import 'package:comro_alt/routes/routes.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: CRoutes.home, page: () => const HomeScreen()),
    // GetPage(name: CRoutes.store, page: () => const StoreScreen()),
    GetPage(name: CRoutes.settings, page: () => const SettingsScreen()),
    GetPage(name: CRoutes.order, page: () => const OrderScreen()),
    GetPage(name: CRoutes.checkout, page: () => const CheckoutScreen()),
    GetPage(name: CRoutes.cart, page: () => const CartScreen()),
    GetPage(name: CRoutes.userProfile, page: () => const ProfileScreen()),
    GetPage(name: CRoutes.userAddress, page: () => const UserAddressScreen()),
    GetPage(name: CRoutes.signup, page: () => const SignUpScreen()),
    GetPage(name: CRoutes.signin, page: () => const LoginScreen()),
    GetPage(name: CRoutes.verifyEmail, page: () => const VerifyEmailScreen()),
    GetPage(name: CRoutes.forgetPassword, page: () => const ForgetPassword()),
  ];
}
