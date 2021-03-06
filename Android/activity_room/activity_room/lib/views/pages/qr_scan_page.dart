import 'dart:io';

import 'package:activity_room/consts/consts.dart';
import 'package:activity_room/services/database_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewPage extends StatefulWidget {
  const QRViewPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewPageState();
}

class _QRViewPageState extends State<QRViewPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 5,
                child: Stack(
                  children: [
                    _buildQrView(context),
                    Positioned(
                      child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                          )),
                      top: 30,
                      left: 20,
                    ),
                  ],
                )),
            Expanded(
              flex: 1,
              child: FittedBox(
                alignment: Alignment.center,
                fit: BoxFit.contain,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    if (result != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text('Room Code : ${result!.code}'),
                      )
                    else
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Scan a code',
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(100, 30)),
                              onPressed: () async {
                                await controller?.toggleFlash();
                                setState(() {});
                              },
                              child: FutureBuilder(
                                future: controller?.getFlashStatus(),
                                builder: (context, snapshot) {
                                  return Text(
                                      'Flash: ${snapshot.data.toString() == "false" ? "OFF" : "ON"}');
                                },
                              )),
                        ),
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: Visibility(
                            visible: result == null ? false : true,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size(100, 30)),
                                onPressed: () async {
                                  if (result != null) {
                                    DatabaseService()
                                        .addRoomCodeToDB(result!.code, context);
                                  }
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Join Room")),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 230.0
        : 360.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: MyColors().homepagecolor,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    // log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
