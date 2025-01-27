import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String id;
  String title;
  double price;
  String description;
  String thumbnail;
  String categories;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.thumbnail,
    required this.categories,
  });

  //create empty function for clean code
  static ProductModel empty() => ProductModel(
        id: '',
        title: '',
        price: 0,
        description: '',
        thumbnail: '',
        categories: '',
      );

  //JSON format
  Map<String, dynamic> toJson() {
    return {
      'Title': title,
      'Price': price,
      'Description': description,
      'Thumbnail': thumbnail,
      'Categories': categories,
    };
  }

  //map json oriented document snapshot from firebase to model
  factory ProductModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return ProductModel.empty();
    final data = document.data()!;
    return ProductModel(
      id: document.id,
      title: data['Title'],
      price: double.parse((data['Price'] ?? 0.0).toString()),
      description: data['Description'] ?? '',
      thumbnail: data['Thumbnail'] ?? '',
      categories: data['Categories'],
    );
  }
}
