import 'package:comro_alt/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:comro_alt/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CPrimaryHeaderContainer extends StatelessWidget {
  const CPrimaryHeaderContainer({
    super.key,
    required this.child,
    required this.height,
  });

  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CColors.primary,
      padding: const EdgeInsets.all(0),
      child: SizedBox(
        height: height,
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -250,
              child: CCircularContainer(
                backgroundColor: CColors.textWhite.withOpacity(0.1),
              ),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: CCircularContainer(
                backgroundColor: CColors.textWhite.withOpacity(0.1),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
