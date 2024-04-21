import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_example/utils/colors/app_colors.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key, required this.barcode}) : super(key: key);
  final ValueChanged<Barcode> barcode;

  @override
  State<StatefulWidget> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
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

  double zoom = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Transform.scale(
              scale: zoom,
              child: QRView(
                key: qrKey,
                onQRViewCreated: (controller) {
                  setState(
                    () {
                      this.controller = controller;
                    },
                  );
                  controller.scannedDataStream.listen(
                    (scanData) {
                      controller.pauseCamera();
                      widget.barcode.call(scanData);
                      Navigator.pop(context);
                    },
                  );
                },
                overlay: QrScannerOverlayShape(
                  borderColor: AppColors.cFDB623,
                  borderRadius: 16 / zoom,
                  borderLength: 40 / zoom,
                  borderWidth: 40 / zoom,
                  cutOutSize:
                      MediaQuery.of(context).size.width / zoom - 32 / zoom,
                ),
                onPermissionSet: (ctrl, p) {
                  log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
                  if (!p) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('no Permission')),
                    );
                  }
                },
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 0,
            left: 0,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10, color: Colors.black.withOpacity(.3))
                  ],
                  color: Colors.black.withOpacity(.5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.photo_library_sharp,
                        color: Color(0xffD9D9D9),
                      )),
                  IconButton(
                      onPressed: () async {
                        await controller?.toggleFlash();
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.flash_on,
                        color: Color(0xffD9D9D9),
                      )),
                  IconButton(
                      onPressed: () async {
                        await controller?.flipCamera();
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.flip_camera_ios,
                        color: Color(0xffD9D9D9),
                      )),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: 140,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      zoom = 1;
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.remove,
                      color: Color(0xffD9D9D9),
                    )),
                const SizedBox(
                  width: 20,
                ),
                IconButton(
                  onPressed: () {

                    zoom = 2;
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Color(0xffD9D9D9),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
