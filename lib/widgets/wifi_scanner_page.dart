import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WifiScannerPage extends StatefulWidget {
  const WifiScannerPage({Key? key}) : super(key: key);

  @override
  State<WifiScannerPage> createState() => _WifiScannerPageState();
}

class _WifiScannerPageState extends State<WifiScannerPage> {
  // Backend URL configuration
  static const String baseUrl = "http://10.0.2.2:8000"; // Use this for Android emulator
  // static const String baseUrl = "http://YOUR_PC_IP:8000"; // Uncomment and set for real devices

  List<dynamic> devices = [];
  String currentEndpoint = '';
  bool isLoading = false;
  String errorText = '';

  void _setError(String message) {
    setState(() {
      isLoading = false;
      devices.clear();
      currentEndpoint = '';
      errorText = message;
    });
  }

  Future<void> fetchData(String endpoint) async {
    if (endpoint == '/arp_scan') {
      _showArpInputDialog();
      return;
    }

    setState(() {
      isLoading = true;
      devices.clear();
      currentEndpoint = endpoint;
      errorText = '';
    });

    try {
      final response = await http.get(Uri.parse('$baseUrl$endpoint')).timeout(const Duration(seconds: 60));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<dynamic> fetchedDevices = [];
        if (endpoint == '/scan') {
          fetchedDevices = data['devices'] ?? [];
        } else if (endpoint == '/heatmap') {
          fetchedDevices = data['heatmap'] ?? [];
        }
        setState(() {
          devices = fetchedDevices;
          errorText = '';
        });
      } else {
        _setError("Server error: ${response.statusCode}");
      }
    } catch (e) {
      _setError("Network error:\n$e\nPlease verify backend is running and the IP address is correct.");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchArpScan(String network) async {
    setState(() {
      isLoading = true;
      devices.clear();
      currentEndpoint = '/arp_scan';
      errorText = '';
    });

    try {
      final response = await http.get(Uri.parse('$baseUrl/arp_scan/$network')).timeout(const Duration(seconds: 60));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          devices = data['devices'] ?? [];
          errorText = '';
        });
      } else {
        _setError("Server error: ${response.statusCode}");
      }
    } catch (e) {
      _setError("Network error:\n$e\nPlease verify backend is running and the IP address is correct.");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showArpInputDialog() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text('Enter Network for ARP Scan', style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'e.g., 192.168.1.0/24',
            hintStyle: TextStyle(color: Colors.white54),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final input = controller.text.trim();
              if (input.isNotEmpty) {
                Navigator.pop(context);
                fetchArpScan(input);
              }
            },
            child: const Text('Scan'),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required String description,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
    required bool loading,
  }) {
    return GestureDetector(
      onTap: loading ? null : onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF22272D),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(50), blurRadius: 7, offset: const Offset(0, 3)),
          ],
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: iconColor.withAlpha(40),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(10),
              child: Icon(icon, color: iconColor, size: 30),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 6),
                  Text(description, style: const TextStyle(color: Colors.white70, fontSize: 14)),
                ],
              ),
            ),
            loading
                ? const SizedBox(width: 26, height: 26, child: CircularProgressIndicator())
                : const Icon(Icons.chevron_right, color: Colors.white30),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceCard(dynamic device) {
    final int risk = device['risk'] ?? device['value'] ?? 0;
    final riskColor = risk > 0 ? Colors.redAccent : Colors.greenAccent;

    final String ip = device['ip'] ?? '';
    final String hostname = device['hostname'] ?? '';
    final String vendor = device['vendor'] ?? '';
    final String mac = device['mac'] ?? '';
    final List ports = device['open_ports'] ?? [];
    final String status = device['status'] ?? 'Safe';
    final String reason = device['reason'] ?? '';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF1D212C), borderRadius: BorderRadius.circular(16)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.devices, size: 32, color: Colors.blue[300]),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(hostname.isNotEmpty && hostname != 'Unknown' ? hostname : ip,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                if (ip.isNotEmpty) Text('IP: $ip', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                if (vendor.isNotEmpty) Text('Vendor: $vendor', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                if (mac.isNotEmpty) Text('MAC: $mac', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                if (ports.isNotEmpty) Text('Open Ports: ${ports.join(", ")}', style: const TextStyle(color: Colors.amber, fontSize: 12)),
                Row(
                  children: [
                    Icon(risk > 0 ? Icons.warning_amber : Icons.check_circle, color: riskColor, size: 18),
                    const SizedBox(width: 6),
                    Text(status, style: TextStyle(color: riskColor, fontWeight: FontWeight.bold)),
                  ],
                ),
                if (reason.isNotEmpty)
                  Text(reason, style: const TextStyle(color: Colors.orangeAccent, fontSize: 12, fontStyle: FontStyle.italic)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(16)),
            child: Text(risk.toString(), style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    IconData icon = Icons.info;
    String title = 'WiFi Scanner';
    List<dynamic> displayDevices = devices;

    if (currentEndpoint == '/scan') {
      icon = Icons.wifi;
      title = 'Scan Network';
    } else if (currentEndpoint == '/heatmap') {
      icon = Icons.heat_pump;
      title = 'Heatmap Data';
    } else if (currentEndpoint == '/arp_scan') {
      icon = Icons.blur_linear;
      title = 'ARP Scan';
    } else {
      displayDevices = [];
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(title, style: const TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            _buildActionButton(
              label: '/scan',
              description: 'Scan Network',
              icon: Icons.wifi,
              iconColor: Colors.blue[300]!,
              onTap: () => fetchData('/scan'),
              loading: isLoading && currentEndpoint == '/scan',
            ),
            _buildActionButton(
              label: '/heatmap',
              description: 'Heatmap Data',
              icon: Icons.heat_pump,
              iconColor: Colors.green[400]!,
              onTap: () => fetchData('/heatmap'),
              loading: isLoading && currentEndpoint == '/heatmap',
            ),
            _buildActionButton(
              label: '/arp_scan',
              description: 'ARP Scan',
              icon: Icons.blur_linear,
              iconColor: Colors.amber[600]!,
              onTap: () => fetchData('/arp_scan'),
              loading: isLoading && currentEndpoint == '/arp_scan',
            ),
            const SizedBox(height: 16),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : errorText.isNotEmpty
                  ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    errorText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              )
                  : displayDevices.isEmpty
                  ? const Center(
                child: Text(
                  'No data.\nTap a button to start.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white54, fontSize: 16),
                ),
              )
                  : ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: displayDevices.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (_, index) => _buildDeviceCard(displayDevices[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
