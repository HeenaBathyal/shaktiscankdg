import 'package:flutter/material.dart';

void main() {
  runApp(const ShaktiApp());
}

class ShaktiApp extends StatelessWidget {
  const ShaktiApp({super.key});
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
      home: const HomePage(),
    );
  }
}

//----------------- HOME PAGE -----------------
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final mainTitleSize = width < 360 ? 32.0 : 44.0;
    final subTitleSize = width < 360 ? 20.0 : 23.0;

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
                            fontSize: 22,
                            color: Color(0xFF30fb85),
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
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                ElevatedButton.icon(
                  icon: const Icon(Icons.sos_outlined, color: Color(0xFF30fb85), size: 18),
                  label: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 11, vertical: 6),
                    child: Text(
                      'SOS Mode',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Color(0xFF30fb85),
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: const BorderSide(color: Color(0xFF30fb85)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const SosEmergencyPage()),
                    );
                  },
                ),
              ],
            ),
          ),
          // Alerts
          Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                color: const Color(0xFFB00000),
                child: Row(
                  children: const [
                    Icon(Icons.warning_amber_rounded, color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'PRIVACY ALERT | 105 hidden cameras detected today',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15, letterSpacing: 1.1),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFF4C00), Color(0xFFFF8D00)],
                  ),
                ),
                child: Row(
                  children: const [
                    Expanded(
                      child: Text(
                        '12 in Public Restrooms',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 1.0),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Illegal recording devices discovered',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Image.asset('assets/logo.png', width: 200, height: 200),
                  const SizedBox(height: 18),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: const Color(0xFF30fb85), width: 1.6),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Text(
                      'Privacy Protection Technology',
                      style: TextStyle(
                        color: Color(0xFF30fb85),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'SHAKTI',
                          style: TextStyle(
                            color: const Color(0xFF30fb85),
                            fontWeight: FontWeight.w900,
                            fontSize: mainTitleSize,
                            letterSpacing: 1.6,
                          ),
                        ),
                        TextSpan(
                          text: 'SCAN',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: mainTitleSize,
                            letterSpacing: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Detect',
                        style: TextStyle(
                          fontSize: subTitleSize,
                          color: const Color(0xFF30fb85),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        'Defend',
                        style: TextStyle(
                          fontSize: subTitleSize,
                          color: const Color(0xFFFFB300),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        'Defy',
                        style: TextStyle(
                          fontSize: subTitleSize,
                          color: const Color(0xFFFF4C4C),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'Advanced privacy protection that detects hidden cameras and spyware using cutting-edge scanning technology',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: 220,
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.rocket_launch, color: Color(0xFF30fb85)),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            color: Color(0xFF30fb85),
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF30fb85), width: 3),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const SecurityFeaturesPage()),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//----------------- SECURITY FEATURES PAGE -----------------
class SecurityFeaturesPage extends StatelessWidget {
  const SecurityFeaturesPage({super.key});
  @override
  Widget build(BuildContext context) {
    const features = [
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
        title: Row(
          children: const [
            Icon(Icons.shield, color: Color(0xFF30fb85)),
            SizedBox(width: 10),
            Text("Security Features",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
          ],
        ),
        backgroundColor: Colors.black,
        elevation: 0,
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
              int idx = features.indexOf(feature);
              return GestureDetector(
                onTap: () {
                  if (feature['title'] == 'Quick Scan Room') {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const QuickScanRoomPage()),
                    );
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: idx < features.length - 1 ? 20 : 0),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF12161E),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
            }),
          ],
        ),
      ),
    );
  }
}

//----------------- QUICK SCAN PAGE (VERTICAL MOBILE UI) -----------------
class QuickScanRoomPage extends StatelessWidget {
  const QuickScanRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color accentGreen = Color(0xFF30fb85);
    const Color cardBg = Color(0xFF181A1C);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: BackButton(color: Colors.white),
        title: Row(
          children: const [
            Icon(Icons.center_focus_strong, color: accentGreen),
            SizedBox(width: 8),
            Text(
              "Quick Scan Room",
              style: TextStyle(
                  color: accentGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 19),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20, top: 14),
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Text(
              "01",
              style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  letterSpacing: 1.1),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Enhanced Surveillance Detection ---
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(18),
              ),
              padding: const EdgeInsets.all(18),
              margin: const EdgeInsets.only(bottom: 21),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.camera_outdoor, color: accentGreen, size: 22),
                      SizedBox(width: 8),
                      Text("Enhanced Surveillance Detection",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Stepper Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      _StepBox(
                        step: 1,
                        title: "Record Room Footage",
                        subtitle: "Scan for 30-60 seconds. Detects hidden cameras AND phone cameras recording you",
                      ),
                      _StepBox(
                        step: 2,
                        title: "AI Processing",
                        subtitle: "Advanced AI analyzes footage for all surveillance devices",
                      ),
                      _StepBox(
                        step: 3,
                        title: "Instant Results",
                        subtitle: "View threats, generate police reports, heatmap locations",
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Container(
                    margin: const EdgeInsets.only(top: 0),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.search, color: accentGreen, size: 18),
                            SizedBox(width: 8),
                            Text("Enhanced Detection Features",
                                style: TextStyle(
                                    color: accentGreen,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 20,
                          children: const [
                            _FeatureBadge(icon: Icons.phone_android, text: "Phone Cameras", color: Colors.orange),
                            _FeatureBadge(icon: Icons.videocam, text: "Hidden Cameras", color: Colors.redAccent),
                            _FeatureBadge(icon: Icons.headset, text: "Audio Devices", color: Colors.lightBlueAccent),
                            _FeatureBadge(icon: Icons.offline_bolt, text: "Offline Ready", color: accentGreen),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            // --- Camera Feed ---
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(18),
              ),
              padding: const EdgeInsets.all(18),
              margin: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Camera Feed",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),
                  ),
                  const SizedBox(height: 7),
                  const Text(
                    "Ready to start recording",
                    style: TextStyle(color: Colors.white70, fontSize: 14.5),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF101118), Color(0xFF20202B)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.play_circle_outline, color: Colors.white30, size: 54),
                          SizedBox(height: 12),
                          Text(
                            "Ready to record room footage",
                            style: TextStyle(color: Colors.white60, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.play_arrow, color: Colors.white),
                      label: const Text(
                        "Start Recording",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade400,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            // --- Recording Instructions ---
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(18),
              ),
              padding: const EdgeInsets.all(18),
              margin: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _InstructionSection(),
                ],
              ),
            ),
            // --- Current Scan ---
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(18),
              ),
              padding: const EdgeInsets.all(18),
              margin: const EdgeInsets.only(bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.access_time, color: accentGreen, size: 20),
                      SizedBox(width: 7),
                      Text(
                        "Current Scan",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 11),
                  Row(
                    children: [
                      const Text("Status:", style: TextStyle(color: Colors.white70)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text(
                          "IDLE",
                          style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 9),
                  Row(
                    children: const [
                      Text("Location:", style: TextStyle(color: Colors.white70)),
                      Spacer(),
                      Text("28.6405, 77.0642", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Stepper widget
class _StepBox extends StatelessWidget {
  final int step;
  final String title;
  final String subtitle;

  const _StepBox({required this.step, required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: const Color(0xFF22292C),
            child: Text(
              '$step',
              style: TextStyle(
                color: step == 1 ? Color(0xFF30fb85) : step == 2 ? Color(0xFF34BE82) : Color(0xFF8ECAE6),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15.5),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.white70, fontSize: 11.5),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _FeatureBadge extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _FeatureBadge({required this.icon, required this.text, required this.color});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 5),
        Text(text, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class _InstructionSection extends StatelessWidget {
  const _InstructionSection();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Recording Instructions",
          style: TextStyle(color: Color(0xFF30fb85), fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: 12),
        _GreenBullet(text: "Record for 30-60 seconds for best results"),
        _GreenBullet(text: "Move camera slowly around all areas of the room"),
        _GreenBullet(text: "Focus on corners, mirrors, electronic devices, and decorations"),
        _GreenBullet(text: "Use flashlight in low-light conditions"),
        _GreenBullet(text: "AI will analyze footage after recording stops"),
      ],
    );
  }
}

class _GreenBullet extends StatelessWidget {
  final String text;
  const _GreenBullet({required this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(color: Color(0xFF30fb85), fontWeight: FontWeight.bold, fontSize: 19)),
          Expanded(child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 14.5))),
        ],
      ),
    );
  }
}

//----------------- SOS PAGE (FULL DETAILED IMPLEMENTATION) -----------------
class SosEmergencyPage extends StatelessWidget {
  const SosEmergencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    // You can later modularize parts if you wish
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: BackButton(color: Colors.white),
        title: Row(
          children: const [
            Icon(Icons.shield, color: Colors.redAccent),
            SizedBox(width: 8),
            Text(
              "SOS Emergency Mode",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
          child: Column(
            children: [
              // Immediate Police Contact
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 18),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0x221B0000),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.red.shade900.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.phone_in_talk, color: Colors.redAccent, size: 22),
                        SizedBox(width: 6),
                        Text(
                          "Immediate Police Contact",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      "Direct emergency services - Use when in immediate danger",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 17),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.phone_callback, color: Colors.white),
                        label: const Text(
                          "CALL 911 EMERGENCY",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16.5,
                          ),
                        ),
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE65657),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.red.shade900.withOpacity(0.4), width: 1),
                              foregroundColor: Colors.white,
                            ),
                            child: const Text(
                              "Police: 911",
                              style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.red.shade900.withOpacity(0.4), width: 1),
                              foregroundColor: Colors.white,
                            ),
                            child: const Text(
                              "Domestic Violence Hotline",
                              style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 13.5),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 7),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: const Text(
                        "When to call 911: Immediate physical danger, active surveillance, perpetrator present, or when you feel unsafe",
                        style: TextStyle(color: Colors.white70, fontSize: 12.5),
                      ),
                    ),
                  ],
                ),
              ),
              // Emergency Contact Alert
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 18),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0x44220a00),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.orange.shade800.withOpacity(0.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.sms_failed_outlined, color: Colors.orange, size: 22),
                        SizedBox(width: 6),
                        Text(
                          "Emergency Contact Alert",
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      "Send SOS alerts to your trusted contacts",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.warning_amber, color: Colors.white),
                        label: const Text(
                          "ACTIVATE SOS ALERT",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16.5,
                          ),
                        ),
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange.shade700.withOpacity(.65),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add_comment, color: Colors.white),
                      label: const Text(
                        "Add Custom Message",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: BorderSide(color: Colors.orange.shade800.withOpacity(0.35)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 7),
                      decoration: BoxDecoration(
                        color: Colors.orange[200]?.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(color: Colors.orange.withOpacity(0.3)),
                      ),
                      child: const Text(
                        "No emergency contacts configured. Set up contacts in Quick Scan for SOS alerts.",
                        style: TextStyle(color: Colors.amber, fontSize: 13.4),
                      ),
                    ),
                  ],
                ),
              ),
              // Current Location
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 18),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFF141716),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.green.shade800.withOpacity(0.4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.location_on, color: Color(0xFF30fb85), size: 22),
                        SizedBox(width: 6),
                        Text(
                          "Current Location",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      "Share this with emergency responders",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 11),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 13),
                      decoration: BoxDecoration(
                        color: const Color(0xFF181D1B),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white12),
                      ),
                      child: const Text(
                        "28.640556,   77.064223",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.5,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.copy_all, size: 16, color: Colors.white),
                            label: const Text("Copy Location", style: TextStyle(color: Colors.white)),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: BorderSide(color: Colors.green.shade800.withOpacity(0.4)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.open_in_new, size: 15, color: Colors.white),
                            label: const Text(
                              "Open in Maps",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: BorderSide(color: Colors.green.shade800.withOpacity(0.4)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      "Location Accuracy: GPS coordinates are shared for emergency response. Enable high accuracy location for best results.",
                      style: TextStyle(color: Colors.white38, fontSize: 12.3),
                    ),
                  ],
                ),
              ),
              // Emergency Contacts
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFF141716),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.contacts, color: Color(0xFF30fb85), size: 21),
                        SizedBox(width: 6),
                        Text(
                          "Emergency Contacts",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      "Configured contacts for SOS alerts",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Column(
                        children: [
                          Icon(Icons.contact_phone, color: Colors.white30, size: 44),
                          const SizedBox(height: 5),
                          const Text(
                            "No emergency contacts configured",
                            style: TextStyle(color: Colors.white54, fontSize: 14.2),
                          ),
                          const SizedBox(height: 13),
                          OutlinedButton(
                            onPressed: () {},
                            child: const Text("Setup Contacts"),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: const BorderSide(color: Colors.white24),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
