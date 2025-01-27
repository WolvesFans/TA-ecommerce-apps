import 'package:flutter/material.dart';

class CProductSubtitleText extends StatelessWidget {
  const CProductSubtitleText({
    super.key,
    required this.subtitle,
  });

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: Theme.of(context).textTheme.labelSmall,
    );
  }
}
