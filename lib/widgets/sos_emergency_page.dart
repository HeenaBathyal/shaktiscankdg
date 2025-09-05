import 'package:flutter/material.dart';

class SosEmergencyPage extends StatelessWidget {
  const SosEmergencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    const cardColor = Color(0xFF141716);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        title: Row(children: const [
          Icon(Icons.shield, color: Colors.redAccent),
          SizedBox(width: 8),
          Text("SOS Emergency Mode",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
        ]),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          // Immediate Police Contact
          _SOSCard(
            title: "Immediate Police Contact",
            icon: Icons.phone_in_talk,
            iconColor: Colors.redAccent,
            description: "Direct emergency services – Use when in immediate danger",
            buttonText: "CALL 911 EMERGENCY",
            buttonColor: Colors.redAccent,
            extraWidgets: [
              Row(children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text("Police: 911",
                        style: TextStyle(color: Colors.redAccent)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text("Domestic Violence Hotline",
                        style: TextStyle(color: Colors.redAccent)),
                  ),
                ),
              ]),
              const SizedBox(height: 8),
              const Text(
                "When to call 911: Immediate physical danger, active surveillance, perpetrator present, or when you feel unsafe",
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),

          // Emergency Contact Alert
          _SOSCard(
            title: "Emergency Contact Alert",
            icon: Icons.sms_failed_outlined,
            iconColor: Colors.orange,
            description: "Send SOS alerts to your trusted contacts",
            buttonText: "ACTIVATE SOS ALERT",
            buttonColor: Colors.orange,
            extraWidgets: [
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add_comment, color: Colors.white),
                label: const Text("Add Custom Message",
                    style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(8)),
                child: const Text(
                  "No emergency contacts configured. Set up contacts in Quick Scan for SOS alerts.",
                  style: TextStyle(color: Colors.amber),
                ),
              ),
            ],
          ),

          // Current Location
          _SOSCard(
            title: "Current Location",
            icon: Icons.location_on,
            iconColor: Colors.greenAccent,
            description: "Share this with emergency responders",
            buttonText: "", // no primary button needed here
            buttonColor: Colors.transparent,
            customContent: Column(children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(8)),
                child: const Text("28.640556,  77.064223",
                    style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 10),
              Row(children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.copy, color: Colors.white),
                    label: const Text("Copy Location",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.open_in_new, color: Colors.white),
                    label: const Text("Open in Maps",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ]),
            ]),
          ),

          // Emergency Contacts
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            decoration:
            BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(14)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: const [
                Icon(Icons.contacts, color: Colors.greenAccent),
                SizedBox(width: 6),
                Text("Emergency Contacts",
                    style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
              ]),
              const SizedBox(height: 8),
              const Text("Configured contacts for SOS alerts",
                  style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 16),
              Center(
                child: Column(children: [
                  Icon(Icons.contact_phone, color: Colors.white30, size: 44),
                  const SizedBox(height: 6),
                  const Text("No emergency contacts configured",
                      style: TextStyle(color: Colors.white54)),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text("Setup Contacts",
                        style: TextStyle(color: Colors.white)),
                  )
                ]),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}

// Reusable SOS card widget
class _SOSCard extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final IconData icon;
  final Color iconColor;
  final Color buttonColor;
  final List<Widget>? extraWidgets;
  final Widget? customContent;

  const _SOSCard({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.description,
    required this.buttonText,
    required this.buttonColor,
    this.extraWidgets,
    this.customContent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(15),
      decoration:
      BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(14)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: 6),
          Text(title,
              style: TextStyle(color: iconColor, fontWeight: FontWeight.bold))
        ]),
        const SizedBox(height: 8),
        Text(description, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 12),
        if (buttonText.isNotEmpty)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  padding: const EdgeInsets.symmetric(vertical: 14)),
              child: Text(buttonText,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        if (extraWidgets != null) ...extraWidgets!,
        if (customContent != null) customContent!,
      ]),
    );
  }
}
