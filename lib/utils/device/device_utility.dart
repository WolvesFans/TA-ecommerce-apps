import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CDeviceUtils {
  //hide keyboard
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  //set status bar kek device color
  static Future<void> setStatusBarColor(Color color) async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: color),
    );
  }

  //ngasi tau klo orientasi lg landscape
  static bool isLandscapeOrientation(BuildContext context) {
    final viewInsets = View.of(context).viewInsets;
    return viewInsets.bottom == 0;
  }

  //ngasi tau klo orientasi lg portrait
  static bool isPortraitOrientation(BuildContext context) {
    final viewInsets = View.of(context).viewInsets;
    return viewInsets.bottom == 1;
  }

  //bikin device jd fullscreen
  static void setFullScreen(bool enable) {
    SystemChrome.setEnabledSystemUIMode(enable ? SystemUiMode.immersiveSticky : SystemUiMode.edgeToEdge);
  }

  //ngambil info tinggi layar
  static double getScreenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  //ngambil info lebar layar
  static double getScreenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  //ngambil info tinggi layar
  static double getPixelRatio() {
    return MediaQuery.of(Get.context!).devicePixelRatio;
  }

  //ngamil info tinggi status bar
  static double getStatusBarHeight() {
    return MediaQuery.of(Get.context!).padding.top;
  }

  //ngamil info tinggi bottom navbar
  static double getBottomNavBarHeight() {
    return kBottomNavigationBarHeight;
  }

  //ngamil info tinggi app bar
  static double getAppBarHeight() {
    return kToolbarHeight;
  }

  //ngamil info tinggi keyboard
  static double getKeyboardHeight() {
    final viewInsets = MediaQuery.of(Get.context!).viewInsets;
    return viewInsets.bottom;
  }

  //pastiin keyboard visible ap egk?
  static Future<bool> isKeyboardVisible() async {
    final viewInsets = MediaQuery.of(Get.context!).viewInsets;
    return viewInsets.bottom > 0;
  }

  //devicenya ap nich
  static Future<bool> isPhysicalDevice() async {
    return defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS;
  }

  //bzz bzz geter brp lama
  static void vibrate(Duration duration) {
    HapticFeedback.vibrate();
    Future.delayed(duration, () => HapticFeedback.vibrate());
  }

  //set orientation
  static Future<void> setPrefferedOrientation(List<DeviceOrientation> orientations) async {
    await SystemChrome.setPreferredOrientations(orientations);
  }

  //hide status bar
  static void hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    );
  }

  //show status bar
  static void showStatusBar() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }

  //cek internet
  static Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  //ngasi tau klo ini device ios
  static bool isIOS() {
    return Platform.isIOS;
  }

  //ngasi tau klo ini device andro
  static bool isAndroid() {
    return Platform.isAndroid;
  }

  //buat launch url
  static void launchUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not access $url';
    }
  }
}
