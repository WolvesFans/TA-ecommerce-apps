import 'package:comro_alt/common/widgets/custom_shapes/container/primary_header_container.dart';
import 'package:comro_alt/common/widgets/texts/section_heading.dart';
import 'package:comro_alt/features/shop/screens/home/widgets/home_contact_us.dart';
import 'package:comro_alt/features/shop/screens/home/widgets/home_our_history.dart';
import 'package:comro_alt/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:comro_alt/features/shop/screens/home/widgets/home_order_type.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //header
            CPrimaryHeaderContainer(
              height: 230,
              child: Column(
                children: [
                  //appbar
                  CHomeAppBar(),
                  SizedBox(height: CSizes.spaceBtwSections),
                ],
              ),
            ),

            //body
            Padding(
              padding: EdgeInsets.all(CSizes.defaultSpace),
              child: Column(
                children: [
                  //order type heading
                  CSectionHeading(
                    title: CText.orderNow,
                    showActionButton: false,
                  ),
                  SizedBox(height: CSizes.spaceBtwItems),

                  //order type
                  CHomeOrderType(),
                  SizedBox(height: CSizes.spaceBtwSections),

                  //our history
                  COurHistory(),
                  SizedBox(height: CSizes.spaceBtwSections * 1.5),

                  //contact us heading
                  CSectionHeading(title: 'Need help?'),
                  SizedBox(height: CSizes.spaceBtwItems),

                  //contact us
                  CContactUs(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
