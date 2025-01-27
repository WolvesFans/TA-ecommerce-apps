import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateController extends GetxController {
  static DateController get instance => Get.find();

  //variable
  final Rx<DateTime?> deliveryDateTime = Rx(null);
  DateTime dayNow = DateTime.now();
 

  Future<void> testDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: dayNow,
      lastDate: dayNow.add(const Duration(days: 90)),
    );
    if (!context.mounted) return;
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 11, minute: 00,),
    );
    if (pickedDate != null && pickedTime != null) {
      deliveryDateTime.value = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,  
      );
    }
  }
}
