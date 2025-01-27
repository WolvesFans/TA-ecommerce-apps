import 'package:comro_alt/common/widgets/login_signup/form_divider.dart';
import 'package:comro_alt/common/widgets/login_signup/social_button.dart';
import 'package:comro_alt/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //title
              Text(
                CText.signUpTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: CSizes.spaceBtwSections),

              //form
              const CSignupForm(),
              const SizedBox(height: CSizes.spaceBtwSections),

              //divider
              const CFormDivider(dividerText: CText.orSignUpWith),
              const SizedBox(height: CSizes.spaceBtwItems),

              //social buttons
              const CSocialButton(),
            ],
          ),
        ),
      ),
    );
  }
}
