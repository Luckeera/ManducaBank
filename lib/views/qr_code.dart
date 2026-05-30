import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRPage extends StatefulWidget {
  const QRPage({super.key});

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  String qrCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leitor QR Code'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: MobileScanner(
              onDetect: (capture) {
                final barcode = capture.barcodes.first;

                if (barcode.rawValue != null) {
                  setState(() {
                    qrCode = barcode.rawValue!;
                  });
                }
              },
            ),
          ),

          Expanded(
            child: Center(
              child: Text(
                qrCode.isEmpty
                    ? 'Escaneie um QR Code'
                    : qrCode,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}