import 'package:comro_alt/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:comro_alt/utils/constants/colors.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class CContactUs extends StatelessWidget {
  const CContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    return CRoundedContainer(
      showBorder: true,
      borderColor: dark ? CColors.white : CColors.black,
      height: 100,
      width: double.infinity,
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.all(CSizes.defaultSpace),
      child: Row(
        children: [
          //icon
          const Icon(
            Bootstrap.whatsapp,
            size: 30,
          ),
          const SizedBox(width: CSizes.spaceBtwItems),

          //contact us text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Comro Echo Customer Service (Chat only)',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(
                '0819-3116-5073',
                style: Theme.of(context).textTheme.titleLarge,
              )
            ],
          ),
        ],
      ),
    );
  }
}
