import 'package:flutter/material.dart';

class CSectionHeading extends StatelessWidget {
  const CSectionHeading({
    super.key,
    this.textColor,
    this.buttonTitle = 'View All',
    required this.title,
    this.showActionButton = false,
    this.onPressed,
  });

  final Color? textColor;
  final String title, buttonTitle;
  final bool showActionButton;
  final void Function()? onPressed; //kalo butuh show all di categories

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall!.apply(color: textColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (showActionButton)
          TextButton(
            onPressed: onPressed,
            child: Text(buttonTitle),
          )
      ],
    );
  }
}
