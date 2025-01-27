import 'package:comro_alt/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:comro_alt/utils/constants/colors.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CCouponCode extends StatelessWidget {
  const CCouponCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    return CRoundedContainer(
      showBorder: true,
      backgroundColor: dark ? CColors.dark : CColors.light,
      padding: const EdgeInsets.symmetric(horizontal: CSizes.md, vertical: CSizes.sm),
      child: Row(
        children: [
          //textfield
          Flexible(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Have a promo code? Enter here!',
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
            ),
          ),

          //apply button
          SizedBox(
            width: 80,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: dark ? CColors.white.withOpacity(0.5) : CColors.dark.withOpacity(0.5),
                backgroundColor: CColors.grey.withOpacity(0.2),
                side: BorderSide(
                  color: CColors.grey.withOpacity(0.1),
                ),
              ),
              child: const Text('Apply'),
            ),
          )
        ],
      ),
    );
  }
}
