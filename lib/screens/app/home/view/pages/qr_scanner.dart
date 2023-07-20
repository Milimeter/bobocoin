import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:binance_cl/constants/value.dart';
import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  Barcode? result;
  String ff = '';
  bool found = false;
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, "");
        return false;
      },
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            return Stack(
              children: [
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () async {
                      await controller!.resumeCamera();
                    },
                    child: Container(
                      margin:
                          EdgeInsets.only(top: constraints.maxHeight * 0.09),
                      child: const Align(
                        alignment: Alignment.topCenter,
                        child: CText(
                          text: "Scan Code",
                          color: kTextColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.pop(context, "");
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          top: constraints.maxHeight * 0.09, left: 30),
                      child: const Align(
                        alignment: Alignment.topLeft,
                        child: Icon(
                          Icons.close,
                          color: kWhiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: constraints.maxHeight * 0.15),
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Values().boxRadius),
                      topRight: Radius.circular(Values().boxRadius),
                    ),
                  ),
                  child: _buildQrView(context),
                ),
                Positioned.fill(
                  child: found == true
                      ? GestureDetector(
                          onTap: () async {
                            if (result != null) {
                              Navigator.pop(context, result!.code);
                            }
                          },
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: heightSize(50),
                              width: widthSize(150),
                              margin: const EdgeInsets.only(bottom: 40),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Values().boxRadius),
                                border: Border.all(color: kWhiteColor),
                              ),
                              child: const Center(
                                child: CText(
                                  text: "Scan Complete",
                                  color: kWhiteColor,
                                  size: 20,
                                  fontFamily: "Poppins-SemiBold",
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Theme.of(context).primaryColor,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    controller.resumeCamera();
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      //log("--02: ${scanData.code}");
      //log(scanData.code!);
      setState(() {
        result = scanData;
        found = true;
      });

      controller.pauseCamera().then((value) {
        Timer(const Duration(seconds: 1), () {
          if (found == true && result != null) {
            Navigator.pop(context, result!.code);
          }
        });
      });

      log(result!.code!);
    }, onDone: () {
      //log("hhh-");
      log("found code: ${result!.code}");
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
