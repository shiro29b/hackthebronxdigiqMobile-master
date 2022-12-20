import 'package:digiq/Constants/round_button.dart';
import 'package:digiq/MyProfileModel/singlequeuemodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';
import 'package:digiq/GetServices/get_services.dart';
import 'package:digiq/Screens/login_sreen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../PostServices/post_services.dart';

class Scanner extends StatefulWidget {
  const Scanner({Key? key}) : super(key: key);


  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {

  PostServices p1= PostServices();
  GetServices g1= GetServices();
  Barcode? result;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;


  @override
  void dispose() {
    // TODO: implement dispose
    controller!.dispose();
    super.dispose();

  }

  @override
  void reassemble() async{
    // TODO: implement reassemble
    super.reassemble();
    if(Platform.isAndroid){
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }



  // Future openDialog()=> showDialog(
  //     context: context,
  //     builder: (context)=>AlertDialog(
  //       title: Text('Queue Info'),
  //       content: TextField(),
  //
  //     ),
  // );
  @override
  Icon getIcon(String tag){
    if(tag == 'Shopping')
      return Icon(FontAwesomeIcons.shoppingCart,color: Colors.white,size: 30,);
    if(tag =='Restaurant')
      return Icon(FontAwesomeIcons.utensils,color: Colors.white,size: 30,);
    if(tag=='Office')
      return Icon(FontAwesomeIcons.building,color: Colors.white,size: 30,);
    return Icon(FontAwesomeIcons.user,color: Colors.white,);
  }

  void _onQrViewCreate(QRViewController controller)
  {
      this.controller=controller;


    controller.scannedDataStream.listen((scanData)async {
      controller.pauseCamera();
      result = scanData;
      print("Result in QR CODE: ${result}");
      SingleQueue res= await getData(result!.code.toString());
      print("res in QR CODE ${res}");
        setState(() {
            if (result != null) {
              showDialog(
              context: context,
              builder: (context) =>
                  Dialog(
                    insetPadding: EdgeInsets.symmetric(
                        vertical: 250, horizontal: 50),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(FontAwesomeIcons.solidCircle,
                                 color: res.isActive ?Colors.green : Colors.red,),
                            ],
                          ),
                        ),

                        Expanded(
                          child: Row(

                            children: [

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: getIcon(res.tag),

                                ),
                              ),

                              AutoSizeText(
                                "${res.name}",
                                maxLines: 2,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 20
                                  ),
                                ),
                              ),


                            ],
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        Text(
                            '${res.count.toString()} In Queue',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(fontSize: 18),
                          ),
                        ),

                        SizedBox(
                          height: 40,
                        ),

                        res.isActive ? RoundedButton(color: Colors.black,
                            title: "Join Queue",
                            onpressed: () async{
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please Wait')),
                              );
                              var joinResult = await p1.ApiJoinLine("", res.id);
                              Fluttertoast.showToast(msg: joinResult);
                              Navigator.of(context)
                                  .pushNamedAndRemoveUntil('/allqueues', (Route<dynamic> route) => false);
                              },
                            textColor: Colors.white) :
                            RoundedButton(color: Colors.black,
                            title: 'InActive',
                                onpressed: (){},
                                textColor: Colors.white
                            ),

                      ],
                    ),
                  ),

            );
          }
        });


    }
        );
    }


  Future<SingleQueue> getData(String id)async{
   return await g1.getSingleLineInfo(id);
   //print("check : ${res.name}");
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: QRView(
              key:qrKey,
              overlay:QrScannerOverlayShape(borderRadius:10,
                borderColor:Colors.red,
                borderLength:30,
                borderWidth:10,
                cutOutSize:300,
              ),
              onQRViewCreated:_onQrViewCreate,
            ),
          ),

        ],
      ),

    );
  }
}
