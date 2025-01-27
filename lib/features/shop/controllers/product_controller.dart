import 'package:comro_alt/data/repositories/product/product_repository.dart';
import 'package:comro_alt/features/shop/models/product_model.dart';
import 'package:comro_alt/utils/constants/image_strings.dart';
import 'package:comro_alt/utils/helpers/network_manager.dart';
import 'package:comro_alt/utils/popups/full_screen_loader.dart';
import 'package:comro_alt/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  Rx<ProductModel> product = ProductModel.empty().obs;
  RxList<ProductModel> storeAlaCarteProducts = <ProductModel>[].obs;
  RxList<ProductModel> storeBundleProducts = <ProductModel>[].obs;
  RxList<ProductModel> storeBeveragesProduct = <ProductModel>[].obs;
  final imageUploading = false.obs;
  GlobalKey<FormState> inputProductFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    fetchStoreProducts();
    super.onInit();
  }

  void fetchStoreProducts() async {
    try {
      //show loading
      isLoading.value = true;

      //fetch products
      // final alaCarteProduct = await productRepository.getProduct('Ala Carte');
      final alaCarteProduct = await productRepository.getAlaCarteProducts();
      final bundleProduct = await productRepository.getBundleProducts();
      // final beveragesProduct = await productRepository.getBeveragesProduct();

      //assign products
      storeAlaCarteProducts.assignAll(alaCarteProduct);
      storeBundleProducts.assignAll(bundleProduct);
      // storeBeveragesProduct.assignAll(beveragesProduct);
    } catch (e) {
      CLoaders.errorSnackBar(
        title: 'Oh Snap :(',
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  //input product
  void inputProduct() async {
    try {
      uploadProductImage();
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
    } catch (e) {
      //remove loader
      CFullScreenLoader.stopLoading();

      //show generic error to user
      CLoaders.errorSnackBar(
        title: 'Oops!',
        message: e.toString(),
      );
    }
  }

  //upload any images
  void uploadProductImage() async {
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
        final imageUrl = await productRepository.uploadImage('Users/Images/Product', image);

        //upload product image record
        Map<String, dynamic> json = {"Thumbnail": imageUrl};
        await productRepository.updateSingleField(json);

        product.value.thumbnail = imageUrl;
        product.refresh();

        inputProduct();
      }
    } catch (e) {
      CLoaders.errorSnackBar(
        title: 'Oh Snap :(',
        message: e.toString(),
      );
    } finally {
      imageUploading.value = false;
    }
  }

  //upload product image to firebase
  pickProductImage() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );
      if (image != null) {
        imageUploading.value = true;
        //upload image to storage
        final imageUrl = await productRepository.uploadImage('Products/Images', image);
        product.value.thumbnail = imageUrl;
        product.refresh();
        CLoaders.successSnackBar(
          title: 'Congrats!',
          message: 'Product image has been added!',
        );
      }
    } catch (e) {
      CLoaders.errorSnackBar(
        title: 'Oh snap!',
        message: 'Something weng wrong: $e',
      );
    }
  }
}
