import 'package:flutter/material.dart';

void main() {
  runApp(const ShaktiScanApp());
}

class ShaktiScanApp extends StatelessWidget {
  const ShaktiScanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShaktiScan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Arial',
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const HomePage(), // This fixes your main screen error!
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double mainTitleSize = screenWidth < 360 ? 32 : 44;
    double subTitleSize = screenWidth < 360 ? 16 : 20;

    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
            child: Row(
              children: [
                Row(
                  children: [
                    // Top left logo
                    Image.asset(
                      'assets/logo.png',
                      width: 60,
                      height: 60,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'SHAKTI',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF30fb85),
                            fontSize: 22,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Text(
                          'SCAN',
                          style: TextStyle(
                            fontSize: 9,
                            color: Color(0xFFD8D8D8),
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.2,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: const BorderSide(color: Color(0xFF30fb85), width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size(82, 32),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    elevation: 0,
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.call, color: Color(0xFF30fb85), size: 14),
                  label: const Text(
                    "SOS Mode",
                    style: TextStyle(
                      color: Color(0xFF30fb85),
                      fontWeight: FontWeight.w500,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Alerts
          Column(
            children: [
              Container(
                width: double.infinity,
                color: Colors.red.shade700,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Row(
                  children: const [
                    Icon(Icons.warning, color: Colors.white, size: 15),
                    SizedBox(width: 8),
                    Text(
                      'PRIVACY ALERT',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        letterSpacing: .5,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      ' | ',
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                    SizedBox(width: 5),
                    Text(
                      '105 hidden cameras ',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    Text(
                      'detected today across all locations',
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFF5300), Color(0xFFFFA500)],
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      '12 in Public Restrooms',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Illegal recording devices discovered',
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Main content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 18),
                  Image.asset(
                    'assets/logo.png',
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Color(0xFF30fb85), width: 1),
                    ),
                    child: const Text(
                      'Privacy Protection Technology',
                      style: TextStyle(
                        color: Color(0xFF30fb85),
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'SHAKTI',
                          style: TextStyle(
                            color: Color(0xFF30fb85),
                            fontWeight: FontWeight.bold,
                            fontSize: mainTitleSize,
                            letterSpacing: 1,
                          ),
                        ),
                        TextSpan(
                          text: 'SCAN',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: mainTitleSize,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Detect.',
                        style: TextStyle(
                          fontSize: subTitleSize,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF30fb85),
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Defend.',
                        style: TextStyle(
                          fontSize: subTitleSize,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFFB300),
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Defy.',
                        style: TextStyle(
                          fontSize: subTitleSize,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFF4C4C),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Advanced privacy protection that detects hidden cameras and spyware\nusing cutting-edge scanning technology',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  ElevatedButton.icon(
                    icon: Icon(Icons.rocket_launch, color: Color(0xFF30fb85), size: 18),
                    label: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF30fb85),
                          fontSize: 16,
                          letterSpacing: .5,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      side: BorderSide(color: Color(0xFF30fb85), width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const SecurityFeaturesPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SecurityFeaturesPage extends StatelessWidget {
  const SecurityFeaturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    const features = [
      {
        'icon': Icons.center_focus_strong,
        'iconColor': Color(0xFF1295db),
        'iconBg': Color(0xFF193044),
        'title': 'Quick Scan Room',
        'desc': 'Record room footage and analyze for hidden surveillance devices',
        'badge': '01',
      },
      {
        'icon': Icons.wifi,
        'iconColor': Color(0xFF30fb85),
        'iconBg': Color(0xFF173424),
        'title': 'WiFi/Network Scanner',
        'desc': 'Scan network for spyware and suspicious devices with nmap',
        'badge': '02',
      },
      {
        'icon': Icons.star_border,
        'iconColor': Color(0xFFFFCC45),
        'iconBg': Color(0xFF382B12),
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
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Security Features",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Comprehensive detection capabilities powered by advanced technology",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Column(
              children: List.generate(features.length, (i) {
                final f = features[i];
                return GestureDetector(
                  onTap: () {
                    if (f['title'] == 'Quick Scan Room') {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const QuickScanPage(),
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: i != features.length - 1 ? 20 : 0),
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 18),
                    decoration: BoxDecoration(
                      color: const Color(0xFF111215),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Icon and badge
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: f['iconBg'] as Color,
                                borderRadius: BorderRadius.circular(9),
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Icon(
                                f['icon'] as IconData,
                                color: f['iconColor'] as Color,
                                size: 32,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white24),
                              ),
                              child: Text(
                                f['badge'] as String,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 22),
                        Text(
                          f['title'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          f['desc'] as String,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class QuickScanPage extends StatelessWidget {
  const QuickScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    double cardPad = 14;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: BackButton(color: Colors.white),
        title: Row(
          children: const [
            Icon(Icons.center_focus_strong, color: Color(0xFF1295db)),
            SizedBox(width: 8),
            Text(
              "Quick Scan Room",
              style: TextStyle(
                color: Color(0xFF30fb85),
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white24),
            ),
            child: const Text(
              "01",
              style: TextStyle(
                color: Colors.white54,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Surveillance Detection Card
              Container(
                padding: EdgeInsets.all(cardPad),
                margin: const EdgeInsets.only(bottom: 18),
                decoration: BoxDecoration(
                  color: const Color(0xFF111215),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.video_camera_front, color: Color(0xFF30fb85), size: 24),
                        SizedBox(width: 8),
                        Text(
                          "Enhanced Surveillance Detection",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Steps
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _NumberedStep(
                          number: 1,
                          title: 'Record Room Footage',
                          subtitle:
                          'Scan for 30-60 seconds. Detects hidden cameras AND phone cameras recording you',
                        ),
                        const SizedBox(width: 12),
                        _NumberedStep(
                          number: 2,
                          title: "AI Processing",
                          subtitle: "Advanced AI analyzes footage for all surveillance devices",
                        ),
                        const SizedBox(width: 12),
                        _NumberedStep(
                          number: 3,
                          title: "Instant Results",
                          subtitle: "View threats, generate police reports, and get heat map locations",
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    // Enhanced Features Row
                    Card(
                      color: const Color(0xFF181a1d),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.search, color: Color(0xFF30fb85), size: 16),
                                SizedBox(width: 5),
                                Text(
                                  "Enhanced Detection Features",
                                  style: TextStyle(
                                    color: Color(0xFF30fb85),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13.5,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 7),
                            Wrap(
                              alignment: WrapAlignment.start,
                              spacing: 12,
                              children: const [
                                _FeatureBadge(
                                  icon: Icons.phone_android,
                                  label: 'Phone Cameras',
                                  color: Color(0xFFFFB300),
                                ),
                                _FeatureBadge(
                                  icon: Icons.videocam,
                                  label: 'Hidden Cameras',
                                  color: Color(0xFFFF4C4C),
                                ),
                                _FeatureBadge(
                                  icon: Icons.headset,
                                  label: 'Audio Devices',
                                  color: Color(0xFF30C1FB),
                                ),
                                _FeatureBadge(
                                  icon: Icons.offline_bolt,
                                  label: 'Offline Ready',
                                  color: Color(0xFFB7E070),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Camera Feed & Instructions (Vertically stacked for mobile)
              Column(
                children: [
                  // Camera Feed
                  Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: EdgeInsets.all(cardPad),
                    decoration: BoxDecoration(
                      color: const Color(0xFF111215),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Camera Feed',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Ready to start recording',
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 13.5,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Container(
                          height: 170,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF181a1d), Color(0xFF21232a)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.insert_drive_file, color: Colors.white38, size: 54),
                                SizedBox(height: 6),
                                Text(
                                  "Ready to record room footage",
                                  style: TextStyle(color: Colors.white60, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.play_arrow, color: Colors.white),
                            label: const Text(
                              "Start Recording",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE65657),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Recording Instructions
                  Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: EdgeInsets.all(cardPad),
                    decoration: BoxDecoration(
                      color: const Color(0xFF111215),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.shield, color: Color(0xFF30fb85), size: 18),
                            SizedBox(width: 6),
                            Text(
                              'Recording Instructions',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 11),
                        const _InstructionBullet(text: "Record for 30-60 seconds for best results"),
                        const _InstructionBullet(text: "Move camera slowly around all areas of the room"),
                        const _InstructionBullet(text: "Focus on corners, mirrors, electronic devices, and decorations"),
                        const _InstructionBullet(text: "Use flashlight in low-light conditions"),
                        const _InstructionBullet(text: "AI will analyze footage after recording stops"),
                      ],
                    ),
                  ),
                  // Current Scan Card
                  Container(
                    padding: EdgeInsets.all(cardPad),
                    decoration: BoxDecoration(
                      color: const Color(0xFF111215),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.access_time, color: Color(0xFF30fb85), size: 18),
                            SizedBox(width: 6),
                            Text(
                              'Current Scan',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Text(
                              'Status:',
                              style: TextStyle(color: Colors.white70),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white24),
                              ),
                              child: const Text(
                                "IDLE",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 7),
                        Row(
                          children: const [
                            Text(
                              'Location:',
                              style: TextStyle(color: Colors.white70),
                            ),
                            Spacer(),
                            Text(
                              '28.6405, 77.0642',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Sub-components for QuickScanPage

class _NumberedStep extends StatelessWidget {
  final int number;
  final String title;
  final String subtitle;

  const _NumberedStep({
    required this.number,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 13,
            backgroundColor: const Color(0xFF232832),
            child: Text(
              '$number',
              style: const TextStyle(color: Color(0xFF30fb85), fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          const SizedBox(width: 7),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.5,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 11.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _FeatureBadge({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 17),
        const SizedBox(width: 5),
        Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13)),
      ],
    );
  }
}

class _InstructionBullet extends StatelessWidget {
  final String text;
  const _InstructionBullet({required this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(color: Color(0xFF30fb85), fontWeight: FontWeight.bold, fontSize: 19)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 13.5),
            ),
          ),
        ],
      ),
    );
  }
}
