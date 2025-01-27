import 'package:comro_alt/utils/constants/colors.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// a widget for displaying an animated loading indicator with optional text and action button
class CAnimationLoaderWidget extends StatelessWidget {
  /// default constructor for the CAnimationLoaderWidget
  ///
  /// Parameters:
  ///   - text: the text to be displayed below the animation
  ///   - animation: the path to the lottie animation file
  ///   - showAction: whether to show an action button below the text
  ///   - actionText: the text to be displayed on the action button
  ///   - onActionPressed: callback function to be executed when the action button is pressed
  const CAnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
  });

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Lottie.asset(
            animation,
            width: MediaQuery.of(context).size.width * 0.75, //display lottie animation
          ),
          const SizedBox(height: CSizes.defaultSpace),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: CSizes.defaultSpace),
          showAction
              ? SizedBox(
                  width: 250,
                  child: OutlinedButton(
                    onPressed: onActionPressed,
                    style: OutlinedButton.styleFrom(backgroundColor: CColors.dark),
                    child: Text(
                      actionText!,
                      style: Theme.of(context).textTheme.bodyMedium!.apply(color: CColors.light),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
