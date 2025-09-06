import 'package:flutter/material.dart';
import 'quick_scan_page.dart';
import 'wifi_scanner_page.dart';  // Import your WiFi Scanner page here

class SecurityFeaturesPage extends StatelessWidget {
  const SecurityFeaturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Define the list of features with explicit types
    const List<Map<String, dynamic>> features = [
      {
        'icon': Icons.center_focus_strong,
        'iconBg': Color(0xFF172837),
        'iconColor': Color(0xFF2D92FE),
        'title': 'Quick Scan Room',
        'desc': 'Record for 30-60 seconds, detects hidden & phone cameras',
        'badge': '01',
      },
      {
        'icon': Icons.wifi,
        'iconBg': Color(0xFF163426),
        'iconColor': Color(0xFF40EC86),
        'title': 'WiFi/Network Scanner',
        'desc': 'Scan network for spyware and suspicious devices',
        'badge': '02',
      },
      {
        'icon': Icons.star_border,
        'iconBg': Color(0xFF3A2D10),
        'iconColor': Color(0xFFFFC43D),
        'title': 'Scan History',
        'desc': 'View previous scans and reports as proof of privacy invasion',
        'badge': '03',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Row(
          children: const [
            Icon(Icons.shield, color: Color(0xFF30fb85)),
            SizedBox(width: 10),
            Text(
              "Security Features",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 14),
        child: Column(
          children: [
            const Text(
              "Comprehensive detection capabilities powered by advanced technology",
              style: TextStyle(color: Colors.white70, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ...features.map((feature) {
              final int idx = features.indexOf(feature);

              return GestureDetector(
                onTap: () {
                  final String title = feature['title'] as String;
                  if (title == 'Quick Scan Room') {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const QuickScanRoomPage(),
                      ),
                    );
                  } else if (title == 'WiFi/Network Scanner') {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const WifiScannerPage(),
                      ),
                    );
                  } else if (title == 'Scan History') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Scan History tapped')),
                    );
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: idx < features.length - 1 ? 20 : 0,
                  ),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF12161E),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: feature['iconBg'] as Color,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Icon(
                          feature['icon'] as IconData,
                          color: feature['iconColor'] as Color,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              feature['title'] as String,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              feature['desc'] as String,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          feature['badge'] as String,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
