import 'dart:io';

import 'package:activity_room/consts/consts.dart';
import 'package:activity_room/models/user.dart';
import 'package:activity_room/services/auth_service.dart';
import 'package:activity_room/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class AttendencePage extends StatefulWidget {
  const AttendencePage({Key? key, required this.roomCode}) : super(key: key);
  final String roomCode;
  @override
  _AttendencePageState createState() => _AttendencePageState();
}

class _AttendencePageState extends State<AttendencePage> {
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
                flex: 7,
                child: Stack(children: [
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
                  Positioned(
                    top: 20,
                    right: 20,
                    child: ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(minimumSize: Size(80, 40)),
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
                ])),
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 270.0
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
    controller.scannedDataStream.listen((scanData) async {
      if (mounted) {
        setState(() {
          result = scanData;
          print("QR Code DATA : " + result!.code.toString());
        });
      }
      await markAttendence(result);
    });
  }

  markAttendence(Barcode? result) async {
    if (currentTimeInSeconds() - double.parse(result!.code!) < 11) {
      await controller!.pauseCamera();
      User user = await DatabaseService().getUserData();
      print(user.email.toString() +
          user.name.toString() +
          user.prn.toString() +
          user.uid.toString());
      await DatabaseService()
          .classroomCollection
          .doc(widget.roomCode)
          .collection('attendance')
          .doc(AuthService().getUID)
          .set({
        "Name": user.name.toString(),
        'Email': user.email.toString(),
        'PRN': user.prn.toString()
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: MyColors().homepagecolor,
          duration: const Duration(seconds: 2),
          content: const Text("Attendance Marked!")));
      Navigator.of(context).pop();
    } else {
      await controller!.pauseCamera();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: MyColors().homepagecolor,
          duration: const Duration(seconds: 2),
          content: const Text("Invalid Code, Try again!")));
      Navigator.of(context).pop();
    }
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    // log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No Permission')),
      );
    }
  }

  double currentTimeInSeconds() {
    var ms = (DateTime.now()).millisecondsSinceEpoch;
    return (ms / 1000);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
