import 'package:comro_alt/features/admin/screens/home/admin_home.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:comro_alt/utils/constants/text_strings.dart';
import 'package:comro_alt/utils/popups/loaders.dart';
import 'package:comro_alt/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CAdminLoginForm extends StatelessWidget {
  CAdminLoginForm({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          //username
          TextFormField(
            controller: usernameController,
            validator: (value) => CValidators.validateEmptyText('Username', value),
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.user),
              labelText: CText.username,
            ),
          ),
          const SizedBox(height: CSizes.spaceBtwInputFields),

          //password
          TextFormField(
            obscureText: true,
            controller: passwordController,
            validator: (value) => CValidators.validatePassword(value),
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.password_check),
              labelText: CText.password,
            ),
          ),
          const SizedBox(height: CSizes.spaceBtwInputFields),

          //sign in
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  if (usernameController.text == "admin" && passwordController.text == "admincomro94") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminHome(),
                      ),
                    );
                  }
                } else {
                  CLoaders.errorSnackBar(
                    title: 'Oh Snap!',
                    message: 'The email/password is invalid!',
                  );
                }
              },
              child: const Text(CText.signIn),
            ),
          )
        ],
      ),
    );
  }
}
