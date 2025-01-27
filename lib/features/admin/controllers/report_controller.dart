import 'package:comro_alt/data/repositories/admin/report_repository.dart';
import 'package:comro_alt/features/shop/models/alt_order_model.dart';
import 'package:comro_alt/features/shop/models/product_model.dart';
import 'package:comro_alt/utils/popups/loaders.dart';
import 'package:get/get.dart';

class ReportController extends GetxController {
  static ReportController get instance => Get.find();

  final reportRepository = Get.put(ReportRepository());
  RxList<AltOrderModel> storeAllOrders = <AltOrderModel>[].obs;

  @override
  void onInit() {
    getAllOrders();
    super.onInit();
  }

  // Future<List<AltOrderModel>> getAllOrders() async {
  //   try {
  //     final orders = await reportRepository.fetchOrders();
  //     return orders;
  //   } catch (e) {
  //     CLoaders.errorSnackBar(
  //       title: 'Orders not found',
  //       message: e.toString(),
  //     );
  //     return [];
  //   }
  // }

  void getAllOrders() async {
    try {
      final allOrders = await reportRepository.fetchOrders();

      //assign report
      storeAllOrders.assignAll(allOrders);
    } catch (e) {
      CLoaders.errorSnackBar(
        title: 'Error',
        message: e.toString(),
      );
    }
  }

  //test
  // Future<List<ProductModel>> testProduct() async {
  //   try {
  //     final products = await reportRepository.testProduct();
  //     return products;
  //   } catch (e) {
  //     CLoaders.errorSnackBar(
  //       title: 'Error aja',
  //       message: e.toString(),
  //     );
  //     return [];
  //   }
  // }
}
