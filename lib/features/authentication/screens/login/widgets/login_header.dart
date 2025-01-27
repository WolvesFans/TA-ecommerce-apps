import 'package:comro_alt/utils/constants/image_strings.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/constants/text_strings.dart';
import 'package:comro_alt/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CLoginHeader extends StatelessWidget {
  const CLoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //logo
        Image.asset(
          dark ? CImage.appLogo : CImage.appLogo,
          height: 160,
        ),
        //title
        Text(CText.loginTitle, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: CSizes.sm),
        Text(CText.loginSubtitle, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
