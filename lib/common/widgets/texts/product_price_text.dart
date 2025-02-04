import 'package:comro_alt/utils/helpers/pricing_calculator.dart';
import 'package:flutter/material.dart';

class CProductPriceText extends StatelessWidget {
  const CProductPriceText({
    super.key,
    required this.price,
    this.maxLines = 1,
    this.isLarge = false,
    this.lineThrough = false,
  });

  final dynamic price;
  final int maxLines;
  final bool isLarge;
  final bool lineThrough;

  @override
  Widget build(BuildContext context) {
    return Text(
      CPricingCalculator.convertToIdr(price, 0),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: isLarge
          ? Theme.of(context).textTheme.headlineSmall!.apply(decoration: lineThrough ? TextDecoration.lineThrough : null)
          : Theme.of(context).textTheme.titleLarge!.apply(decoration: lineThrough ? TextDecoration.lineThrough : null),
    );
  }
}
