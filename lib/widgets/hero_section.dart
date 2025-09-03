import 'package:flutter/material.dart';
import '../theme.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Detect Hidden Cameras Instantly', style: heroTitleStyle),
          SizedBox(height: 20),
          Text(
            'Advanced hidden camera detection with SOS and WiFi scan features.',
            style: heroSubtitleStyle,
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: null,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Text('Get Started'),
            ),
          ),
        ],
      ),
    );
  }
}
