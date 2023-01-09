import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../my_theme.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';


class ScanImaging extends StatefulWidget {
  const ScanImaging({Key? key}) : super(key: key);

  @override
  State<ScanImaging> createState() => _ScanImagingState();
}

class _ScanImagingState extends State<ScanImaging>  {
  final GlobalKey _gLobalkey = GlobalKey();
  QRViewController? controller;
  Barcode? result;
  void qr(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((event) {
      setState(() {
        result = event;
      });
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Center(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset("assets/laser.png",
                      height: 60,
                      width: 40,
                    )
                  ],
                ),
                Container(
                  height: 5*MediaQuery.of(context).size.height/7,
                  width: 400,

                  child: Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15),
                    child: QRView(
                      key: _gLobalkey,
                      onQRViewCreated: qr,
                      cameraFacing: CameraFacing.back,
                      overlay: QrScannerOverlayShape(
                        borderLength: 20,
                        borderWidth: 4,
                        borderColor: Colors.lightGreenAccent,
                        cutOutHeight:MediaQuery.of(context).size.height*0.26,
                        cutOutWidth: MediaQuery.of(context).size.width*0.7,
                      ),
                    ),
                  ),
                ),
                // Center(
                //   child: (result !=null) ? Text('${result!.code}') : Text('Scan a code'),
                // ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Text('Part ID',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                        ),),
                      Text('')
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Text('Part Name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                        ),),
                      Text('')
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),


                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          color: MyTheme.materialColor,
                          child: TextButton(onPressed: (){},
                              child: Text("Upload & Scan New Part",
                                style: TextStyle(
                                    fontSize:13,
                                    color: MyTheme.white

                                ) ,
                              )),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          color: MyTheme.materialColor,
                          child: TextButton(onPressed: (){},
                              child: Text("Offline Mode",
                                style: TextStyle(
                                    fontSize:13,
                                    color: MyTheme.white

                                ) ,
                              )),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          color: MyTheme.materialColor,
                          child: TextButton(onPressed: (){
                            Navigator.pop(context);
                          },
                              child: Text("Exit",
                                style: TextStyle(
                                    fontSize:13,
                                    color: MyTheme.white

                                ) ,
                              )),
                        ),
                      ),


                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
  }
  // Future<void> scanBarcode() async{
  //   // var status = await Permission.camera.request();
  //   // if (status.isGranted) {
  //     try{
  //        scanResult = await FlutterBarcodeScanner.scanBarcode("#ff66666","Cancel",true,ScanMode.BARCODE);
  //
  //
  //     }on PlatformException{
  //       scanResult="failed";
  //     }
  //     if(!mounted) return;
  //     setState((){
  //       this.scanResult=scanResult;
  //
  //     });
    // } else {
    //   print("error");
    // }



