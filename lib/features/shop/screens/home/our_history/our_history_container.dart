import 'package:comro_alt/common/widgets/appbar/appbar.dart';
import 'package:comro_alt/features/shop/screens/home/our_history/our_history_header.dart';
import 'package:comro_alt/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

class COurHistoryContainer extends StatelessWidget {
  const COurHistoryContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        showBackArrow: true,
        title: Text(
          'Our History',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: CSizes.defaultSpace),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                //header
                const CHistoryHeader(),
                const SizedBox(height: CSizes.spaceBtwSections),

                //content
                Text(
                  loremIpsum(
                    paragraphs: 3,
                  ),
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
