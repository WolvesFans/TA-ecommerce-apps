import 'package:comro_alt/common/widgets/appbar/appbar.dart';
import 'package:comro_alt/common/widgets/layouts/vertical_layout.dart';
import 'package:comro_alt/features/admin/controllers/report_controller.dart';
import 'package:comro_alt/features/admin/screens/report/widgets/admin_order_report.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminReport extends StatelessWidget {
  const AdminReport({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReportController());
    return Scaffold(
      appBar: CAppBar(
        showBackArrow: true,
        title: Text(
          'Order Report',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          // child: FutureBuilder(
          //   future: controller.getAllOrders(),
          //   builder: (context, snapshot) {
          //     //helper function: handle loader, no record, or error message
          //     final response = CCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
          //     if (response != null) return response;

          //     final orders = snapshot.data!;
          //     // final products = snapshot.data!;

          //     return ListView.builder(
          //       shrinkWrap: true,
          //       itemCount: orders.length,
          //       itemBuilder: (_, index) => COrderReport(
          //         order: orders[index],
          //       ),
          //     );
          //   },
          // ),
          child: CVerticalLayout(
            itemCount: controller.storeAllOrders.length,
            itemBuilder: (_, index) => COrderReport(order: controller.storeAllOrders[index]),
          ),
        ),
      ),
    );
  }
}
