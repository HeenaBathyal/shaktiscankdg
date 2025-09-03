import 'package:flutter/material.dart';
import '../theme.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: footerColor,
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      child: const Text(
        '© 2025 Shaktiscan. All rights reserved.',
        style: footerTextStyle,
      ),
    );
  }
}
