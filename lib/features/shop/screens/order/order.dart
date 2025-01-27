import 'package:comro_alt/common/widgets/appbar/appbar.dart';
import 'package:comro_alt/features/shop/screens/order/widgets/order_list.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar
      appBar: CAppBar(
        title: Text(
          'Your order',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),

      //orders
      body: const Padding(
        padding: EdgeInsets.all(CSizes.defaultSpace),
        child: COrderListItems(),
      ),
    );
  }
}
