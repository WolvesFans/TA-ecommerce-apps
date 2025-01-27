import 'dart:io';

import 'package:comro_alt/data/repositories/order/alt_order_repository.dart';
import 'package:comro_alt/features/shop/controllers/date_controller.dart';
import 'package:comro_alt/features/shop/models/alt_order_model.dart';
import 'package:comro_alt/utils/popups/loaders.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class TransferController extends GetxController {
  static TransferController get instance => Get.find();

  //variables
  final imageUploading = false.obs;
  final altOrderRepository = Get.put(AltOrderRepository());
  final String imageUrl = '';
  final Rx<File?> _selectedImage = Rx<File?>(null);
  File? get selectedImage => _selectedImage.value;

  // uploadTransferReceipt() async {
  //   try {
  //     final image = await ImagePicker().pickImage(
  //       source: ImageSource.gallery,
  //       imageQuality: 70,
  //       maxHeight: 512,
  //       maxWidth: 512,
  //     );
  //     if (image != null) {
  //       imageUploading.value = true;
  //       //upload image
  // await altOrderRepository.uploadImage('Orders/Images', image);
  //       CLoaders.successSnackBar(
  //         title: 'Congrats!',
  //         message: 'Your receipt has been sent!',
  //       );
  //     }
  //   } catch (e) {
  //     CLoaders.errorSnackBar(
  //       title: 'Oh Snap!',
  //       message: 'Something went wrong: $e',
  //     );
  //   } finally {
  //     imageUploading.value = false;
  //   }
  // }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      maxHeight: 512,
      maxWidth: 512,
    );

    if (pickedImage != null) {
      _selectedImage.value = File(pickedImage.path);
      update();

      try {
        //upload image to firebase storage
        await altOrderRepository.uploadImage('Orders/Images', _selectedImage.value!);
      } catch (e) {
        CLoaders.errorSnackBar(
          title: 'Oh Snap!',
          message: e.toString(),
        );
      }
    }
  }
}
