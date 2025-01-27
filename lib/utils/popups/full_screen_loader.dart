import 'package:comro_alt/common/widgets/loaders/animation_loader.dart';
import 'package:comro_alt/utils/constants/colors.dart';
import 'package:comro_alt/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// a utility class for managing a full-screen loading dialog
class CFullScreenLoader {
  /// open a full-screen loading dialog with a given text and animation. 
  /// this method doesn't return anything
  ///
  /// parameters:
  ///   - text : the text to be displayed in the loading dialog
  ///   - animation: the lottie animation to be shown
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!, //use Get.overlayContext for overlay dialogs
      barrierDismissible: false, //the dialog can't be dismissed by tapping outside it
      builder: (_) => PopScope(
        canPop: false, //disable popping with the back button
        child: Container(
          color: CHelperFunctions.isDarkMode(Get.context!) ? CColors.dark : CColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 250),
              CAnimationLoaderWidget(text: text, animation: animation)
            ],
          ),
        ),
      ),
    );
  }
  //stop currently open loading dialog
  //this method doesn't turn anything
  static stopLoading(){
    Navigator.of(Get.overlayContext!).pop(); //close the dialog using navigator
  }
}


