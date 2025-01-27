import 'package:comro_alt/features/shop/models/product_model.dart';
import 'package:comro_alt/features/shop/screens/product_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:comro_alt/features/shop/screens/product_details/widgets/product_image.dart';
import 'package:comro_alt/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CBottomAddToCart(product: product),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //product image
            CProductImage(product: product),

            //product details
            Padding(
              padding: const EdgeInsets.all(CSizes.defaultSpace),
              child: Column(
                children: [
                  //price, title, stock, brand
                  CProductMetaData(product: product),
                  const SizedBox(height: CSizes.spaceBtwItems),

                  //attributes
                  // CProductAttributes(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
