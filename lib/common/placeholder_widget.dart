import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlaceHolderWidget extends StatelessWidget {
  final String label;
  const PlaceHolderWidget({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'images/chat.svg',
              height: 200,
              fit: BoxFit.fitHeight,
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
