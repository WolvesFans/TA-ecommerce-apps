import 'package:comro_alt/common/widgets/texts/section_heading.dart';
import 'package:comro_alt/features/shop/controllers/date_controller.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class CBillingDateSection extends StatefulWidget {
  const CBillingDateSection({super.key});

  @override
  State<CBillingDateSection> createState() => _CBillingDateSectionState();
}

class _CBillingDateSectionState extends State<CBillingDateSection> {
  DateTime? selectedDate;
  DateTime now = DateTime.now();
  final dateController = DateController.instance;
  

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //heading
        CSectionHeading(
          title: 'Shipping Date',
          buttonTitle: 'Select Date',
          showActionButton: true,
          onPressed: () async => dateController.testDate(context),
        ),
        const SizedBox(height: CSizes.spaceBtwItems),

        //date
        Obx(
          () => Row(
            children: [
              const Icon(
                Iconsax.calendar,
                size: 16,
              ),
              const SizedBox(width: CSizes.spaceBtwItems / 2),
              Text(
                dateController.deliveryDateTime.value != null
                  ? DateFormat('E, dd MMM yyyy - HH.mm').format(dateController.deliveryDateTime.value!)
                  : 'Select delivery date',
              ),
            ],
          ),
        ),
        const SizedBox(height: CSizes.spaceBtwItems / 2),

      ],
    );
  }
}