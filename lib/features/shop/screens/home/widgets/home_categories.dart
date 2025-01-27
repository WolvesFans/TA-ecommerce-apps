import 'package:comro_alt/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:comro_alt/utils/constants/colors.dart';
import 'package:comro_alt/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CHomeCategories extends StatelessWidget {
  const CHomeCategories({
    super.key,
    required this.text1,
    required this.text2,
    required this.text3,
    this.onPressed1,
    this.onPressed2,
    this.onPressed3,
  });

  final String text1, text2, text3;
  final VoidCallback? onPressed1, onPressed2, onPressed3;

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    return SizedBox(
      height: 30,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 1,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return Row(
            children: [
              CVerticalImageText(
                title: text1,
                textColor: dark ? CColors.softGrey : CColors.black,
                onPressed: onPressed1,
              ),
              CVerticalImageText(
                title: text2,
                textColor: dark ? CColors.softGrey : CColors.black,
                onPressed: onPressed2,
              ),
              CVerticalImageText(
                title: text3,
                textColor: dark ? CColors.softGrey : CColors.black,
                onPressed: onPressed3,
              ),
            ],
          );
        },
      ),
    );
  }
}
