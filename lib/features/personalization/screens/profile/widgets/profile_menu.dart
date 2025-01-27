import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CProfileMenu extends StatelessWidget {
  const CProfileMenu({
    super.key,
    required this.title,
    required this.value,
    this.icon = Iconsax.arrow_right_34,
    required this.onPressed,
  });

  final String title, value;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: CSizes.spaceBtwItems / 1.5),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Icon(
              icon,
              size: 18,
            )
          ],
        ),
      ),
    );
  }
}
