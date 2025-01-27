import 'package:comro_alt/features/personalization/screens/settings/settings.dart';
import 'package:comro_alt/features/shop/screens/cart/cart.dart';
import 'package:comro_alt/features/shop/screens/home/home.dart';
import 'package:comro_alt/utils/constants/colors.dart';
import 'package:comro_alt/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = CHelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 60,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          backgroundColor: darkMode ? CColors.black : CColors.white,
          indicatorColor: darkMode ? CColors.white.withOpacity(0.1) : CColors.black.withOpacity(0.1),
          destinations: const [
            NavigationDestination(
              icon: Icon(Iconsax.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.shopping_cart),
              label: 'Cart',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.profile_circle),
              label: 'Profile',
            ),
          ],
        ),
      ),
      body: Obx(
        () => controller.screens[controller.selectedIndex.value],
      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const CartScreen(),
    const SettingsScreen(),
  ];
}
