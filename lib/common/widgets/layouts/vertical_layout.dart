import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CVerticalLayout extends StatelessWidget {
  const CVerticalLayout({
    required this.itemCount,
    required this.itemBuilder,
    super.key,
  });

  final int itemCount;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (_, __) => const SizedBox(height: CSizes.spaceBtwSections),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
