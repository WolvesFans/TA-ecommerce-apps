import 'package:comro_alt/common/styles/spacing_styles.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

  final String title, subtitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: CSpacingStyles.paddingWithAppBarHeight * 2,
          child: Column(
            children: [             
              //title & subtitle
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: CSizes.spaceBtwItems),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: CSizes.spaceBtwSections),

              //buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: const Text(CText.cContinue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
