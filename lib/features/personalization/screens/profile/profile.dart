import 'package:comro_alt/common/widgets/appbar/appbar.dart';
import 'package:comro_alt/common/widgets/images/circular_image.dart';
import 'package:comro_alt/common/widgets/texts/section_heading.dart';
import 'package:comro_alt/features/personalization/controllers/user_controller.dart';
import 'package:comro_alt/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:comro_alt/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:comro_alt/utils/constants/colors.dart';
import 'package:comro_alt/utils/constants/image_strings.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/constants/text_strings.dart';
import 'package:comro_alt/utils/etc/shimmer.dart';
import 'package:comro_alt/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    final dark = CHelperFunctions.isDarkMode(context);
    return Scaffold(
      //appbar
      appBar: CAppBar(
        showBackArrow: true,
        title: Text(
          CText.profile,
          style: Theme.of(context).textTheme.headlineSmall!.apply(color: dark ? CColors.white : CColors.black),
        ),
      ),

      //body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: CSizes.defaultSpace),
          child: Column(
            children: [
              //profpic
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      final image = networkImage.isNotEmpty ? networkImage : CImage.gehu;
                      return controller.imageUploading.value
                          ? const CShimmerEffect(
                              width: 80,
                              height: 80,
                              radius: 80,
                            )
                          : CCircularImage(
                              image: image,
                              width: 80,
                              height: 80,
                              isNetworkImage: networkImage.isNotEmpty,
                            );
                    }),
                    TextButton(
                      onPressed: () => controller.uploadUserProfilePicture(),
                      child: const Text('Change Profile Picture'),
                    ),
                  ],
                ),
              ),

              //divider 1
              const SizedBox(height: CSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: CSizes.spaceBtwItems),

              //heading profile info
              const CSectionHeading(title: 'Profile Information'),
              const SizedBox(height: CSizes.spaceBtwItems),

              //profile info
              CProfileMenu(
                title: 'Name',
                value: controller.user.value.fullName,
                onPressed: () => Get.to(() => const ChangeName()),
              ),
              CProfileMenu(
                title: CText.username,
                value: controller.user.value.username,
                onPressed: () {},
              ),

              //divider 2
              const Divider(),
              const SizedBox(height: CSizes.spaceBtwItems),

              //heading personal info
              const CSectionHeading(title: 'Personal Information'),
              const SizedBox(height: CSizes.spaceBtwItems),

              //personal info
              CProfileMenu(
                title: 'User ID',
                value: controller.user.value.id,
                onPressed: () {},
              ),
              CProfileMenu(
                title: CText.email,
                value: controller.user.value.email,
                onPressed: () {},
              ),
              CProfileMenu(
                title: CText.phoneNumber,
                value: controller.user.value.formattedPhoneNumber,
                onPressed: () {},
              ),
              CProfileMenu(
                title: CText.gender,
                value: CText.male,
                onPressed: () {},
              ),
              CProfileMenu(
                title: CText.dateOfBirth,
                value: '3 July 2002',
                onPressed: () {},
              ),
              const Divider(),
              const SizedBox(height: CSizes.spaceBtwItems),

              //close acc
              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: const Text(
                    CText.closeAccount,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
