import 'package:flutter/material.dart';
import '../theme.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Shaktiscan', style: headerStyle),
          Row(
            children: [
              _NavButton(label: 'Features'),
              _NavButton(label: 'Pricing'),
              _NavButton(label: 'About'),
              _NavButton(label: 'Contact'),
            ],
          )
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String label;
  const _NavButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Add navigation or scroll logic here
      },
      child: Text(label, style: navItemStyle),
    );
  }
}
