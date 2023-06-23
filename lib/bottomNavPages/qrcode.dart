import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class UserQRCode extends StatefulWidget {
  const UserQRCode({Key? key}) : super(key: key);

  @override
  State<UserQRCode> createState() => _MyCustomWidgetState();
}

class _MyCustomWidgetState extends State<UserQRCode> {
  var getResult = 'QR Code Result';

  @override
  void initState() {
    super.initState();
    scanQRCode();
  }

  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(getResult),
          ],
        ),
      ),
    );*/
    return Container();
  }

  void scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (!mounted) return;

      setState(() {
        getResult = qrCode;
      });

      if (kDebugMode) {
        print("QRCode_Result:--");
      }

      if (kDebugMode) {
        print(qrCode);
      }
    } on PlatformException {
      //toast message
      getResult = 'Failed to scan QR Code.';
    }
  }
}
