import 'package:comro_alt/common/styles/spacing_styles.dart';
import 'package:comro_alt/common/widgets/login_signup/form_divider.dart';
import 'package:comro_alt/common/widgets/login_signup/social_button.dart';
import 'package:comro_alt/features/authentication/screens/login/widgets/login_form.dart';
import 'package:comro_alt/features/authentication/screens/login/widgets/login_header.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: CSpacingStyles.paddingWithAppBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //logo, title, subtitle
              CLoginHeader(),

              //form
              CLoginForm(),

              //divider
              CFormDivider(dividerText: CText.orSignInWith),
              SizedBox(height: CSizes.spaceBtwItems),

              //footer
              CSocialButton()
            ],
          ),
        ),
      ),
    );
  }
}
