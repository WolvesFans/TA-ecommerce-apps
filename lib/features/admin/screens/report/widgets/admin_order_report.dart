import 'package:comro_alt/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:comro_alt/features/shop/models/alt_order_model.dart';
import 'package:comro_alt/features/shop/models/product_model.dart';
import 'package:comro_alt/utils/constants/colors.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class COrderReport extends StatelessWidget {
  const COrderReport({
    super.key,
    required this.order,
  });

  final AltOrderModel order;

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    return CRoundedContainer(
      padding: const EdgeInsets.all(CSizes.md),
      width: double.infinity,
      showBorder: true,
      backgroundColor: Colors.transparent,
      borderColor: dark ? CColors.darkerGrey : CColors.grey,
      margin: const EdgeInsets.only(bottom: CSizes.spaceBtwItems),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //order date
          Text(
            order.id,
          ),

          //total amount
          // Text(
          //   order.totalAmount.toString(),
          // ),
        ],
      ),
    );
  }
}
