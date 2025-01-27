import 'package:comro_alt/common/widgets/appbar/appbar.dart';
import 'package:comro_alt/features/admin/screens/order_list/widgets/admin_order_list.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AdminOrderList extends StatelessWidget {
  const AdminOrderList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        showBackArrow: true,
        title: Text(
          'Order List',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(CSizes.defaultSpace),
        child: CAdminOrderList(),
      ),
    );
  }
}
