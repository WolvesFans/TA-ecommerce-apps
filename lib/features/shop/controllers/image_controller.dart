import 'package:comro_alt/features/shop/models/product_model.dart';
import 'package:get/get.dart';

class ImageController extends GetxController {
  static ImageController get instance => Get.find();

  //variables
  RxString productImage = ''.obs;

  //get all images
  List<String> getAllProductImages(ProductModel product) {
    //use set to add unique images only
    Set<String> images = {};

    //load thumbnail image
    images.add(product.thumbnail);

    //assign thumbnail as selected image
    productImage.value = product.thumbnail;

    return images.toList();
  }
}
