import 'package:comro_alt/utils/constants/image_strings.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CHistoryHeader extends StatelessWidget {
  const CHistoryHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //product logo
        Image.asset(
          CImage.appLogo,
          height: 200,
          width: 200,
        ),
        const SizedBox(height: CSizes.spaceBtwItems / 4),

        //comro title
        Text(
          'Comro Echo',
          style: Theme.of(context).textTheme.headlineMedium,
        ),

        //
      ],
    );
  }
}
