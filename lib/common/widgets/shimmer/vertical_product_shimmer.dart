import 'package:comro_alt/common/widgets/layouts/vertical_layout.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/etc/shimmer.dart';
import 'package:flutter/material.dart';

class CVerticalProductShimmer extends StatelessWidget {
  const CVerticalProductShimmer({
    super.key,
    this.itemCount = 4,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return CVerticalLayout(
      itemCount: itemCount,
      itemBuilder: (_, __) => const SizedBox(
        height: 125,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: CSizes.sm),
          child: Row(
            children: [
              //image
              CShimmerEffect(width: 100, height: 100),
              SizedBox(width: CSizes.spaceBtwItems),

              //details
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      CShimmerEffect(width: 160, height: 15),
                      CShimmerEffect(width: 200, height: 15)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
