import 'package:comro_alt/features/shop/models/cart_item_model.dart';
import 'package:comro_alt/features/shop/models/product_model.dart';
import 'package:comro_alt/utils/local_storage/storage_utility.dart';
import 'package:comro_alt/utils/popups/loaders.dart';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  //variables
  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  CartController() {
    loadCartItems();
  }

  //add items to cart
  void addToCart(ProductModel product) {
    //quantity check
    if (productQuantityInCart.value < 1) {
      CLoaders.customToast(message: 'Select quantity');
      return;
    }

    final selectedCartItem = convertToCartItem(product, productQuantityInCart.value);

    //check if already added in cart
    int index = cartItems.indexWhere((cartItem) => cartItem.productId == selectedCartItem.productId);

    if (index >= 0) {
      //this quantity is already added or updated/removed from the design (cart)(-)
      cartItems[index].quantity = selectedCartItem.quantity;
    } else {
      cartItems.add(selectedCartItem);
    }

    updateCart();
    CLoaders.customToast(message: 'Your selected product has been added to cart!');
  }

  //add one item to cart
  void addOneToCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) => cartItem.productId == item.productId);

    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(item);
    }
    updateCart();
  }

  //remove one item to cart
  void removeOneToCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) => cartItem.productId == item.productId);

    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        //show dialog before completely removing
        cartItems[index].quantity == 1 ? removeFromCartDialog(index) : cartItems.removeAt(index);
      }
      updateCart();
    }
  }

  //remove from cart dialog
  void removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: 'Remove Product',
      middleText: 'Are you sure want to remove this product?',
      onConfirm: () {
        //remove the item from the cart
        cartItems.removeAt(index);
        updateCart();
        CLoaders.customToast(message: 'Product removed from the cart.');
        Get.back();
      },
      onCancel: () => () => Get.back(),
    );
  }

  //initialize already added items count in the cart
  void updateAlreadyAddedProductCount(ProductModel product) {
    //calculate cartEntries and display total number
    productQuantityInCart.value = getProductQuantityInCart(product.id);
  }

  //converts a ProductModel to a CartItemModel
  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    final price = product.price;

    return CartItemModel(
      productId: product.id,
      quantity: quantity,
      price: price,
      image: product.thumbnail,
      title: product.title,
    );
  }

  //update cart values
  void updateCart() {
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  //update cart totals
  void updateCartTotals() {
    double calculatedTotalPrice = 0.0;
    int calculatedNoOfItems = 0;

    for (var item in cartItems) {
      calculatedTotalPrice += (item.price) * item.quantity.toDouble();
      calculatedNoOfItems += item.quantity;
    }

    totalCartPrice.value = calculatedTotalPrice;
    noOfCartItems.value = calculatedNoOfItems;
  }

  //save cart items
  void saveCartItems() {
    final cartItemString = cartItems.map((item) => item.toJson()).toList();
    CLocalStorage.instance().writeData('cartItems', cartItemString);
  }

  //load cart items
  void loadCartItems() {
    final cartItemString = CLocalStorage.instance().readData<List<dynamic>>('cartItems');
    if (cartItemString != null) {
      cartItems.assignAll(cartItemString.map((item) => CartItemModel.fromJson(item as Map<String, dynamic>)));
      updateCartTotals();
    }
  }

  //get product quantity
  int getProductQuantityInCart(String productId) {
    final foundItem = cartItems
        .where(
          (item) => item.productId == productId,
        )
        .fold(
          0,
          (previousValue, element) => previousValue + element.quantity,
        );
    return foundItem;
  }

  //clear cart
  void clearCart() {
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }
}
