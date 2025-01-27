class CartItemModel {
  String productId;
  String title;
  double price;
  String? image;
  int quantity;

  //constructor
  CartItemModel({
    required this.productId,
    required this.quantity,
    this.title = '',
    this.price = 0.0,
    this.image,
  });

  //empty cart
  static CartItemModel empty() => CartItemModel(productId: '', quantity: 0);

  //convert a CartItem to JSON Model
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'title': title,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }

  //create a CartItem from a JSON Map
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId'],
      title: json['title'],
      price: json['price'].toDouble(),
      image: json['image'],
      quantity: json['quantity'],
    );
  }
}
