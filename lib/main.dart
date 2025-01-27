// ignore_for_file: prefer_const_constructors

import 'package:comro_alt/data/repositories/auth/auth_repository.dart';
import 'package:comro_alt/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:comro_alt/app.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

//entry point of apps
Future<void> main() async {
  //add widget bindings
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  //init getx local storage
  await GetStorage.init();

  //todo: await native splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //todo: initialize firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
    (FirebaseApp value) => Get.put(AuthRepository()),
  );

  //todo: initialize authentication

  runApp(const App());
}
