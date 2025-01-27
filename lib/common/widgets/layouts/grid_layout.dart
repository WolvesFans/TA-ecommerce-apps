import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CGridLayout extends StatelessWidget {
  const CGridLayout({
    super.key,
    required this.itemCount,
    this.mainAxisExtent = 200,
    required this.itemBuilder,
  });

  final int itemCount;
  final double? mainAxisExtent;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: mainAxisExtent,
        mainAxisSpacing: CSizes.gridViewSpacing,
        crossAxisSpacing: CSizes.gridViewSpacing,
      ),
      itemBuilder: itemBuilder,
    );
  }
}