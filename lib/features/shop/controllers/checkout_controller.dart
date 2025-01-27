import 'package:comro_alt/common/widgets/list_tiles/payment_tile.dart';
import 'package:comro_alt/common/widgets/texts/section_heading.dart';
import 'package:comro_alt/features/shop/models/payment_method_model.dart';
import 'package:comro_alt/utils/constants/image_strings.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod = PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value = PaymentMethodModel(name: 'GoPay', image: CImage.gopayIcon);
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(CSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //heading
              const CSectionHeading(
                title: 'Select payment method',
                showActionButton: false,
              ),
              const SizedBox(height: CSizes.spaceBtwSections),

              //gopay
              CPaymentTile(
                paymentMethod: PaymentMethodModel(name: 'Gopay', image: CImage.gopayIcon),
              ),
              const SizedBox(height: CSizes.spaceBtwItems / 2),

              //ovo
              CPaymentTile(
                paymentMethod: PaymentMethodModel(name: 'OVO', image: CImage.ovoIcon),
              ),

              //bca
              CPaymentTile(
                paymentMethod: PaymentMethodModel(name: 'BCA Transfer', image: CImage.bcaIcon),
              ),

              //cod
              CPaymentTile(
                paymentMethod: PaymentMethodModel(name: 'Cash on Delivery', image: CImage.codIcon),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
