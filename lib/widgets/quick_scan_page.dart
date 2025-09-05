import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:permission_handler/permission_handler.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class QuickScanRoomPage extends StatefulWidget {
  const QuickScanRoomPage({super.key});

  @override
  State<QuickScanRoomPage> createState() => _QuickScanRoomPageState();
}

class _QuickScanRoomPageState extends State<QuickScanRoomPage> {
  CameraController? _cameraController;
  Interpreter? _interpreter;
  List<String> _labels = [];
  bool _modelReady = false, _isScanning = false;
  bool _isProcessing = false; // Prevent concurrent frame processing
  String _status = "Model loading...";
  List<DetectionResult> _detections = [];

  @override
  void initState() {
    super.initState();
    _setup();
  }

  Future<void> _setup() async {
    await Permission.camera.request();
    await _loadModel();
    final cams = await availableCameras();
    if (cams.isNotEmpty) {
      _cameraController = CameraController(
        cams.first,
        ResolutionPreset.medium,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );
      await _cameraController!.initialize();
      if (mounted) setState(() {});
    }
  }

  Future<void> _loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/model_unquant.tflite');
      final data = await DefaultAssetBundle.of(context).loadString('assets/labels.txt');
      _labels = data.split('\n').where((l) => l.isNotEmpty).toList();
      if (mounted) {
        setState(() {
          _modelReady = true;
          _status = "Model ready";
        });
      }
    } catch (e) {
      if (mounted) setState(() => _status = "Model load error");
    }
  }

  void _startScan() {
    if (!_modelReady || _isScanning || _cameraController == null) return;

    _detections.clear();
    _isScanning = true;
    _status = "Scanning...";
    setState(() {});

    _cameraController!.startImageStream((CameraImage image) async {
      if (!_isScanning || _isProcessing) return;
      _isProcessing = true;

      final det = await _analyzeCameraImage(image);
      if (mounted) {
        if (det != null) {
          setState(() {
            _detections = [det]; // latest detection only
            _status = "Threat detected: ${det.label}";
          });
        } else {
          setState(() {
            _detections.clear();
            _status = "No threats detected";
          });
        }
      }

      _isProcessing = false;
    });
  }

  void _stopScan() {
    if (!_isScanning) return;
    _isScanning = false;
    _status = "Scan stopped";
    _cameraController?.stopImageStream();
    setState(() {});
  }

  Future<DetectionResult?> _analyzeCameraImage(CameraImage image) async {
    try {
      final imgData = _convertYUV420toImage(image);
      if (imgData == null) return null;

      final resized = img.copyResize(imgData, width: 224, height: 224);

      final input = Float32List(1 * 224 * 224 * 3);
      int idx = 0;
      for (var y = 0; y < 224; y++) {
        for (var x = 0; x < 224; x++) {
          final p = resized.getPixel(x, y);
          input[idx++] = p.r / 255.0;
          input[idx++] = p.g / 255.0;
          input[idx++] = p.b / 255.0;
        }
      }
      final inTensor = input.reshape([1, 224, 224, 3]);
      final out = List.filled(1 * _labels.length, 0.0).reshape([1, _labels.length]);
      _interpreter!.run(inTensor, out);

      double maxConfidence = 0;
      int maxIndex = 0;
      for (int i = 0; i < _labels.length; i++) {
        if (out[0][i] > maxConfidence) {
          maxConfidence = out[0][i];
          maxIndex = i;
        }
      }
      if (maxConfidence > 0.7) {
        return DetectionResult(_labels[maxIndex], maxConfidence);
      }
    } catch (e) {
      // silently ignore errors
    }
    return null;
  }

  img.Image? _convertYUV420toImage(CameraImage image) {
    try {
      final width = image.width;
      final height = image.height;
      final imgData = img.Image(width: width, height: height);
      final yPlane = image.planes[0];
      final uPlane = image.planes[1];
      final vPlane = image.planes[2];
      final uvRowStride = uPlane.bytesPerRow;
      final uvPixelStride = uPlane.bytesPerPixel!;

      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          final uvIndex = (y ~/ 2) * uvRowStride + (x ~/ 2) * uvPixelStride;
          final yIndex = y * yPlane.bytesPerRow + x;

          final yp = yPlane.bytes[yIndex];
          final up = uPlane.bytes[uvIndex];
          final vp = vPlane.bytes[uvIndex];

          int r = (yp + vp * 1436 ~/ 1024 - 179).clamp(0, 255);
          int g = (yp - up * 46549 ~/ 131072 - vp * 93604 ~/ 131072 + 135).clamp(0, 255);
          int b = (yp + up * 1814 ~/ 1024 - 226).clamp(0, 255);

          imgData.setPixelRgb(x, y, r, g, b);
        }
      }
      return imgData;
    } catch (e) {
      return null;
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _interpreter?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const accentGreen = Color(0xFF30fb85);
    const cardBg = Color(0xFF181A1C);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        title: const Row(children: [
          Icon(Icons.center_focus_strong, color: accentGreen),
          SizedBox(width: 8),
          Text("Quick Scan Room",
              style: TextStyle(color: accentGreen, fontWeight: FontWeight.bold))
        ]),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20, top: 14),
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
            decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(18)),
            child: const Text("01",
                style: TextStyle(color: Colors.white70, fontSize: 14)),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: double.infinity,
            decoration:
            BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(18)),
            padding: const EdgeInsets.all(18),
            margin: const EdgeInsets.only(bottom: 21),
            child: Row(children: [
              Icon(_modelReady ? Icons.check : Icons.hourglass_empty,
                  color: _modelReady ? Colors.green : Colors.orange),
              const SizedBox(width: 8),
              Expanded(
                  child: Text(_status, style: const TextStyle(color: Colors.white70)))
            ]),
          ),
          Container(
            decoration:
            BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(18)),
            padding: const EdgeInsets.all(18),
            margin: const EdgeInsets.only(bottom: 20),
            child: Column(children: [
              const Text("Live Scan",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 7),
              Container(
                height: 250,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
                child: _cameraController?.value.isInitialized == true
                    ? ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: CameraPreview(_cameraController!))
                    : const Center(child: CircularProgressIndicator(color: accentGreen)),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(_isScanning ? Icons.stop : Icons.play_arrow,
                      color: Colors.white),
                  label: Text(_isScanning ? "Stop Scan" : "Start AI Scan",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                      _isScanning ? Colors.orange : Colors.redAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 13)),
                  onPressed: _isScanning ? _stopScan : _startScan,
                ),
              ),
            ]),
          ),
          if (_detections.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.red.shade900.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("⚠️ Threats Detected",
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    ..._detections.map((d) => Text(
                      "${d.label}: ${(d.confidence * 100).toStringAsFixed(1)}%",
                      style: const TextStyle(color: Colors.white),
                    ))
                  ]),
            ),
        ]),
      ),
    );
  }
}

class DetectionResult {
  final String label;
  final double confidence;
  DetectionResult(this.label, this.confidence);
}



