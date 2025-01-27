import 'package:comro_alt/common/widgets/appbar/appbar.dart';
import 'package:comro_alt/common/widgets/custom_shapes/container/primary_header_container.dart';
import 'package:comro_alt/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:comro_alt/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:comro_alt/common/widgets/texts/section_heading.dart';
import 'package:comro_alt/data/repositories/auth/auth_repository.dart';
import 'package:comro_alt/features/admin/screens/login/admin_login.dart';
import 'package:comro_alt/features/personalization/screens/address/address.dart';
import 'package:comro_alt/features/personalization/screens/profile/profile.dart';
import 'package:comro_alt/utils/constants/colors.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //header
            CPrimaryHeaderContainer(
              height: 170,
              child: Column(
                children: [
                  //appbar
                  CAppBar(
                    title: Text(
                      'Account',
                      style: Theme.of(context).textTheme.headlineSmall!.apply(color: CColors.white),
                    ),
                  ),

                  //user profile card
                  CUserProfileTile(
                    onPressed: () => Get.to(() => const ProfileScreen()),
                  )
                ],
              ),
            ),

            //body
            Padding(
              padding: const EdgeInsets.all(CSizes.defaultSpace),
              child: Column(
                children: [
                  //account setting
                  const CSectionHeading(title: 'Account Settings'),
                  const SizedBox(height: CSizes.spaceBtwItems),

                  CSettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subtitle: 'Set delivery address',
                    onTap: () => Get.to(() => const UserAddressScreen()),
                  ),
                  const CSettingsMenuTile(
                    icon: Iconsax.document,
                    title: 'My Order',
                    subtitle: CText.comingSoon,
                  ),
                  const CSettingsMenuTile(
                    icon: Iconsax.bank,
                    title: 'Bank Account',
                    subtitle: CText.comingSoon,
                  ),
                  const CSettingsMenuTile(
                    icon: Iconsax.discount_circle,
                    title: 'My Discount',
                    subtitle: CText.comingSoon,
                  ),
                  const CSettingsMenuTile(
                    icon: Iconsax.notification,
                    title: 'Notifications',
                    subtitle: CText.comingSoon,
                  ),
                  const CSettingsMenuTile(
                    icon: Iconsax.security_card,
                    title: 'Account Privacy',
                    subtitle: CText.comingSoon,
                  ),
                  CSettingsMenuTile(
                    icon: Iconsax.user_octagon,
                    title: 'Admin?',
                    subtitle: "Open here if you're an admin",
                    onTap: () => Get.to(() => const AdminLoginScreen()),
                  ),

                  //app settings
                  const SizedBox(height: CSizes.spaceBtwSections),
                  const CSectionHeading(
                    title: 'Apps Settings',
                  ),
                  const SizedBox(height: CSizes.spaceBtwItems),
                  const CSettingsMenuTile(
                    icon: Iconsax.document_upload,
                    title: 'Upload Data',
                    subtitle: CText.comingSoon,
                  ),

                  //logout
                  const SizedBox(height: CSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => AuthRepository.instance.logout(),
                      child: const Text(
                        CText.signOut,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
