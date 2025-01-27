// ignore_for_file: prefer_const_constructors

import 'package:comro_alt/bindings/general_bindings.dart';
// import 'package:comro_alt/routes/app_routes.dart';
import 'package:comro_alt/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:comro_alt/utils/theme/theme.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

//pake class ini buat setup themes, initial bindings, animations, etc..
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: CAppTheme.lightTheme,
      darkTheme: CAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      // getPages: AppRoutes.pages,
      home: const Scaffold(
        backgroundColor: CColors.primary,
        body: Center(
          child: CircularProgressIndicator(color: CColors.white),
        ),
      ),
    );
  }
}
