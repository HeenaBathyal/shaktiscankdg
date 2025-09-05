import 'package:flutter/material.dart';
import 'security_features_page.dart';
import 'sos_emergency_page.dart';

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
                    Image.asset('assets/logo.png', width: 60, height: 60),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('SHAKTI',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Color(0xFF30fb85),
                                letterSpacing: 1.2)),
                        Text('SCAN',
                            style: TextStyle(
                                fontSize: 9,
                                color: Color(0xFFD8D8D8),
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1.2)),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                ElevatedButton.icon(
                  icon: const Icon(Icons.sos_outlined,
                      color: Color(0xFF30fb85), size: 18),
                  label: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 11, vertical: 6),
                    child: Text('SOS Mode',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: Color(0xFF30fb85),
                            letterSpacing: 1.2)),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: const BorderSide(color: Color(0xFF30fb85)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SosEmergencyPage()));
                  },
                ),
              ],
            ),
          ),
          // Alerts
          Column(children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
              color: const Color(0xFFB00000),
              child: Row(children: const [
                Icon(Icons.warning_amber_rounded,
                    color: Colors.white, size: 18),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                      'PRIVACY ALERT | 105 hidden cameras detected today',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          letterSpacing: 1.1),
                      overflow: TextOverflow.ellipsis),
                )
              ]),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFFFF4C00), Color(0xFFFF8D00)]),
              ),
              child: Row(children: const [
                Expanded(
                  child: Text('12 in Public Restrooms',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          letterSpacing: 1.0),
                      overflow: TextOverflow.ellipsis),
                ),
                Expanded(
                  child: Text('Illegal recording devices discovered',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                      overflow: TextOverflow.ellipsis),
                )
              ]),
            ),
          ]),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(children: [
                Image.asset('assets/logo.png', width: 200, height: 200),
                const SizedBox(height: 18),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                        color: const Color(0xFF30fb85), width: 1.6),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Text('Privacy Protection Technology',
                      style: TextStyle(
                          color: Color(0xFF30fb85),
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          letterSpacing: 1.2)),
                ),
                const SizedBox(height: 18),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'SHAKTI',
                        style: TextStyle(
                            color: const Color(0xFF30fb85),
                            fontWeight: FontWeight.w900,
                            fontSize: mainTitleSize,
                            letterSpacing: 1.6)),
                    TextSpan(
                        text: 'SCAN',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: mainTitleSize,
                            letterSpacing: 1.6)),
                  ]),
                ),
                const SizedBox(height: 8),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Detect',
                          style: TextStyle(
                              fontSize: subTitleSize,
                              color: const Color(0xFF30fb85),
                              fontWeight: FontWeight.w700)),
                      const SizedBox(width: 20),
                      Text('Defend',
                          style: TextStyle(
                              fontSize: subTitleSize,
                              color: const Color(0xFFFFB300),
                              fontWeight: FontWeight.w700)),
                      const SizedBox(width: 20),
                      Text('Defy',
                          style: TextStyle(
                              fontSize: subTitleSize,
                              color: const Color(0xFFFF4C4C),
                              fontWeight: FontWeight.w700)),
                    ]),
                const SizedBox(height: 14),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                      'Advanced privacy protection that detects hidden cameras and spyware using cutting-edge scanning technology',
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: 220,
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.rocket_launch,
                        color: Color(0xFF30fb85)),
                    label: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text('Get Started',
                          style: TextStyle(
                              color: Color(0xFF30fb85),
                              fontWeight: FontWeight.w700,
                              fontSize: 18)),
                    ),
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: Color(0xFF30fb85), width: 3),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35))),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const SecurityFeaturesPage()));
                    },
                  ),
                ),
                const SizedBox(height: 50),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
