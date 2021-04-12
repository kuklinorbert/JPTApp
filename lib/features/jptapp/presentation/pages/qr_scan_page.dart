import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jptapp/features/jptapp/domain/entities/item.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:easy_localization/easy_localization.dart';

class QrScanPage extends StatefulWidget {
  @override
  _QrScanPageState createState() => _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;
  Map<String, Item> items;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    items = ModalRoute.of(context).settings.arguments;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              child: _buildQrView(),
            ),
            Container(
              child: _buildQrItems(context),
            )
          ],
        ),
      ),
    );
  }

  Row _buildQrItems(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              iconSize: MediaQuery.of(context).size.height / 18,
              icon: Icon(Icons.flash_on),
              color: Colors.white,
              onPressed: () async {
                await controller?.toggleFlash();
              }),
          IconButton(
              iconSize: MediaQuery.of(context).size.height / 18,
              icon: Icon(Icons.flip_camera_android),
              color: Colors.white,
              onPressed: () async {
                await controller?.flipCamera();
              }),
        ]);
  }

  Widget _buildQrView() {
    var scanArea = MediaQuery.of(context).size.width * 0.8;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        cutOutSize: scanArea,
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        checkIfExists(result.code);
      });
    });
  }

  Future<void> _showDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('alert_notf'.tr()),
          content: Text('alert_cont'.tr()),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  controller?.resumeCamera();
                },
                child: Text('alert_back'.tr()))
          ],
        );
      },
    );
  }

  void checkIfExists(String code) {
    if (items.containsKey(code)) {
      controller?.pauseCamera();
      Navigator.of(context)
          .pushReplacementNamed('/details', arguments: items[code]);
    } else {
      controller?.pauseCamera();
      _showDialog();
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
    controller.dispose();
  }
}
