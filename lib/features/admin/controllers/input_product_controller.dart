import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comro_alt/data/repositories/product/product_repository.dart';
import 'package:comro_alt/features/shop/controllers/product_controller.dart';
import 'package:comro_alt/features/shop/models/product_model.dart';
import 'package:comro_alt/utils/constants/image_strings.dart';
import 'package:comro_alt/utils/helpers/network_manager.dart';
import 'package:comro_alt/utils/popups/full_screen_loader.dart';
import 'package:comro_alt/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class InputProductController extends GetxController {
  static InputProductController get instance => Get.find();

  //variables
  final imageUploading = false.obs;
  final productController = Get.put(ProductController());
  Rx<ProductModel> product = ProductModel.empty().obs;
  final productRepository = Get.put(ProductRepository());
  final title = TextEditingController(); //controller for title
  final price = TextEditingController(); //controller for price
  final description = TextEditingController(); //controller for description
  String selectedCategory = '';
  String networkImage = '';
  void updateSelectedCategory(String newSelection) {
    selectedCategory = newSelection;
  }

  final firestore = FirebaseFirestore.instance;

  final GlobalKey<FormState> inputProductFormKey = GlobalKey<FormState>(); //form key validation

  //upload product image
  uploadProductImage() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );
      if (image != null) {
        imageUploading.value = true;
        //upload image
        final imageUrl = await productRepository.uploadImage('Products/Images', image);

        //update product image record
        // Map<String, dynamic> json = {'Thumbnail': imageUrl};
        // await productRepository.updateSingleField(json);

        product.value.thumbnail = imageUrl;
        product.refresh();
        CLoaders.successSnackBar(
          title: 'Congrats!',
          message: 'Your product image has been added!',
        );
      }
    } catch (e) {
      CLoaders.errorSnackBar(
        title: 'Oh Snap!',
        message: 'Something went wrong: $e',
      );
    } finally {
      imageUploading.value = false;
    }
  }

  //input product
  void inputProduct() async {
    try {
      //start loading
      CFullScreenLoader.openLoadingDialog('Processing your information', CImage.loadingAnimation);

      //check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //remove loader
        CFullScreenLoader.stopLoading();
        return;
      }

      //form validation
      if (!inputProductFormKey.currentState!.validate()) {
        //remove loader
        CFullScreenLoader.stopLoading();
        return;
      }


      //save authenticated product data in the firebase firestore
      final newProduct = ProductModel(
        id: '',
        title: title.text.trim(),
        price: double.parse(price.text.trim()),
        description: description.text.trim(),
        thumbnail: product.value.thumbnail,
        categories: selectedCategory,
      );

      final productRepository = Get.put(ProductRepository());
      await productRepository.saveProductRecord(newProduct);

      //remove loader
      CFullScreenLoader.stopLoading();

      //show success message
      CLoaders.successSnackBar(
        title: 'Congrats!',
        message: 'A product has been added!',
      );

      //back to admin home screen
    } catch (e) {
      //remove loaders
      CFullScreenLoader.stopLoading();

      //show generic error to admin
      CLoaders.errorSnackBar(
        title: 'Oops!',
        message: e.toString(),
      );
    }
  }

  //new add image
}
