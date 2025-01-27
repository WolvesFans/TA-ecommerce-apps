import 'package:comro_alt/common/widgets/appbar/appbar.dart';
import 'package:comro_alt/features/admin/screens/login/widgets/admin_login_form.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AdminLoginScreen extends StatelessWidget {
  const AdminLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        title: Text(
          'Admin Login',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(CSizes.defaultSpace),
        child: Column(
          children: [
            //login form
            CAdminLoginForm(),
          ],
        ),
      ),
    );
  }
}
