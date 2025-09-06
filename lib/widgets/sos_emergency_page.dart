import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';

class SosEmergencyPage extends StatefulWidget {
  const SosEmergencyPage({super.key});

  @override
  _SosEmergencyPageState createState() => _SosEmergencyPageState();
}

class _SosEmergencyPageState extends State<SosEmergencyPage> {
  List<String> emergencyContacts = [];

  @override
  void initState() {
    super.initState();
    _loadEmergencyContacts();
  }

  Future<void> _loadEmergencyContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final contactsString = prefs.getString('emergency_contacts');
    if (contactsString != null) {
      setState(() {
        emergencyContacts = List<String>.from(jsonDecode(contactsString));
      });
    }
  }

  Future<void> _saveEmergencyContacts() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('emergency_contacts', jsonEncode(emergencyContacts));
  }

  void _addContact() {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Emergency Contact'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(hintText: 'Enter phone number with country code'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              String newContact = controller.text.trim();
              if (newContact.isNotEmpty && !emergencyContacts.contains(newContact)) {
                setState(() {
                  emergencyContacts.add(newContact);
                });
                _saveEmergencyContacts();
              }
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _removeContact(String contact) {
    setState(() {
      emergencyContacts.remove(contact);
    });
    _saveEmergencyContacts();
  }

  void _editContact(String oldContact) {
    TextEditingController controller = TextEditingController(text: oldContact);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Emergency Contact'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(hintText: 'Enter phone number with country code'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              String updatedContact = controller.text.trim();
              if (updatedContact.isNotEmpty) {
                setState(() {
                  int index = emergencyContacts.indexOf(oldContact);
                  if (index != -1) {
                    emergencyContacts[index] = updatedContact;
                  }
                });
                _saveEmergencyContacts();
              }
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _callNumber(String number) async {
    final Uri launchUri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not make call to $number'))
      );
    }
  }

  void _activateSosAlert() {
    if (emergencyContacts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No emergency contacts configured'))
      );
      return;
    }
    for (var contact in emergencyContacts) {
      _callNumber(contact);
    }
  }

  Future<Position> _getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> _sendSms(String phoneNumber, String messageBody) async {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: {'body': messageBody},
    );
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      throw Exception('Could not launch SMS app');
    }
  }

  String _formatPhoneNumberForWhatsApp(String number) {
    return number.replaceAll(RegExp(r'\D'), '');
  }

  Future<void> _sendWhatsApp(String phoneNumber, String message) async {
    final formattedNumber = _formatPhoneNumberForWhatsApp(phoneNumber);
    final String url = 'https://wa.me/$formattedNumber?text=${Uri.encodeComponent(message)}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw Exception('Could not launch WhatsApp');
    }
  }

  Future<List<String>?> _showContactPickerDialog() async {
    List<String> selectedContacts = [];

    return showDialog<List<String>>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Contacts to Share Location'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return SizedBox(
                width: double.maxFinite,
                child: ListView(
                  shrinkWrap: true,
                  children: emergencyContacts.map((contact) {
                    bool isSelected = selectedContacts.contains(contact);
                    return CheckboxListTile(
                      title: Text(contact, style: const TextStyle(color: Colors.black)),
                      value: isSelected,
                      onChanged: (checked) {
                        setState(() {
                          if (checked == true) {
                            selectedContacts.add(contact);
                          } else {
                            selectedContacts.remove(contact);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, selectedContacts);
              },
              child: const Text('Share'),
            )
          ],
        );
      },
    );
  }

  Future<void> _shareLocationToContacts(List<String> contactsToShare) async {
    try {
      Position position = await _getCurrentPosition();
      String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}';
      String message = "SOS! I am in danger. My current location is: $googleMapsUrl";

      for (var contact in contactsToShare) {
        await _sendSms(contact, message);
        await _sendWhatsApp(contact, message);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sharing location: $e')),
      );
    }
  }

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
                    onPressed: () => _callNumber('911'),
                    child: const Text("Police: 911",
                        style: TextStyle(color: Colors.redAccent)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _callNumber('18002738255'),
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
            onPressed: _activateSosAlert,
            extraWidgets: [
              OutlinedButton.icon(
                onPressed: _addContact,
                icon: const Icon(Icons.add_comment, color: Colors.white),
                label: const Text("Add Custom Contact",
                    style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(8)),
                child: emergencyContacts.isEmpty
                    ? const Text(
                  "No emergency contacts configured. Add contacts above.",
                  style: TextStyle(color: Colors.amber),
                )
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: emergencyContacts.map(
                        (contact) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => _callNumber(contact),
                              icon: const Icon(Icons.phone, color: Colors.orange),
                              label: Text(contact,
                                  style: const TextStyle(color: Colors.white)),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.white70),
                            onPressed: () => _editContact(contact),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () => _removeContact(contact),
                          ),
                        ],
                      ),
                    ),
                  ).toList(),
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
            buttonText: "",
            buttonColor: Colors.transparent,
            customContent: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(8)),
                  child: FutureBuilder<Position>(
                    future: _getCurrentPosition(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text('Fetching location...',
                            style: TextStyle(color: Colors.white));
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}',
                            style: const TextStyle(color: Colors.redAccent));
                      } else {
                        final pos = snapshot.data!;
                        return Text(
                          '${pos.latitude.toStringAsFixed(6)},  ${pos.longitude.toStringAsFixed(6)}',
                          style: const TextStyle(color: Colors.white),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Row(children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        if (emergencyContacts.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('No emergency contacts configured')),
                          );
                          return;
                        }
                        final selected =
                        await _showContactPickerDialog();
                        if (selected != null && selected.isNotEmpty) {
                          await _shareLocationToContacts(selected);
                        }
                      },
                      icon: const Icon(Icons.share, color: Colors.white),
                      label: const Text(
                        "Share Location",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        Position pos = await _getCurrentPosition();
                        final url = Uri.parse(
                            'https://www.google.com/maps/search/?api=1&query=${pos.latitude},${pos.longitude}');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Could not open Maps')),
                          );
                        }
                      },
                      icon: const Icon(Icons.open_in_new, color: Colors.white),
                      label: const Text(
                        "Open in Maps",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ]),
              ],
            ),
          ),

          // Emergency Contacts Section
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
              emergencyContacts.isEmpty
                  ? Center(
                child: Column(children: [
                  Icon(Icons.contact_phone, color: Colors.white30, size: 44),
                  const SizedBox(height: 6),
                  const Text("No emergency contacts configured",
                      style: TextStyle(color: Colors.white54)),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: _addContact,
                    child: const Text("Setup Contacts",
                        style: TextStyle(color: Colors.white)),
                  )
                ]),
              )
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...emergencyContacts.map(
                        (contact) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => _callNumber(contact),
                              icon: const Icon(Icons.phone, color: Colors.greenAccent),
                              label: Text(
                                contact,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.white70),
                            onPressed: () => _editContact(contact),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () => _removeContact(contact),
                          ),
                        ],
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: _addContact,
                    child: const Text("Add More Contacts",
                        style: TextStyle(color: Colors.white)),
                  )
                ],
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _SOSCard extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final IconData icon;
  final Color iconColor;
  final Color buttonColor;
  final List<Widget>? extraWidgets;
  final Widget? customContent;
  final VoidCallback? onPressed;

  const _SOSCard({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.description,
    required this.buttonText,
    required this.buttonColor,
    this.extraWidgets,
    this.customContent,
    this.onPressed,
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
              onPressed: onPressed,
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
