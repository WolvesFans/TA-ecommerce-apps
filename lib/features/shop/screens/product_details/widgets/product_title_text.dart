import 'package:flutter/material.dart';

class CProductTitleText extends StatelessWidget {
  const CProductTitleText({
    super.key,
    required this.title,
    this.isLarge = true,
    this.maxLines = 2,
    this.textAlign = TextAlign.left,
  });

  final String title;
  final bool isLarge;
  final int maxLines;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: isLarge ? Theme.of(context).textTheme.headlineMedium : Theme.of(context).textTheme.titleLarge,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
