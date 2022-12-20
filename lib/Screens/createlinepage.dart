import 'package:digiq/Constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../PostServices/post_services.dart';

class CreateLinePage extends StatefulWidget {
  const CreateLinePage({Key? key}) : super(key: key);

  @override
  _CreateLinePageState createState() => _CreateLinePageState();
}

class _CreateLinePageState extends State<CreateLinePage> {
  int dropVal=1;
  bool isQrActive = false;
  dynamic lineNumber;
  PostServices p1 = PostServices();
  TextEditingController name = TextEditingController();
  TextEditingController qname = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController tpuser = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void generateQR()
  {
    setState(() {
      if(isQrActive) {
        isQrActive = false;
      }
      else {
        isQrActive = true;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(left: width*0.04,top: height*0.08),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Create a Line",style: textStyles.copyWith(fontSize: 32,fontWeight: FontWeight.bold),),
                  SizedBox(height: 0.05*height,),
                  Text("Enter your Queue name",style: textStyles.copyWith(fontSize: 16),),
                  TextFormField(
                    controller: qname,
    validator: (value) {
      if (value == null || value.isEmpty) {
          return 'Please enter some text';
      }
      return null;
    }
                  ),
                  SizedBox(height: 0.02*height,),
                  Text("Enter City Name",style: textStyles.copyWith(fontSize: 16)),
                  TextFormField(
                    controller: location,
    validator: (value) {
      if (value == null || value.isEmpty) {
          return 'Please enter some text';
      }
      return null;
    }
                  ),
                  SizedBox(height: 0.02*height,),
                  Text("Enter estimated time per user(in minutes)",style: textStyles.copyWith(fontSize: 16)),
                  TextFormField(
                    controller: tpuser,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    if (int.parse(value)<=0) {
                      return 'Please enter a positive value';
                    }
                    return null;
                  }
                  ),
                  SizedBox(height: 0.02*height,),
                  Text("Select a Category",style: textStyles.copyWith(fontSize: 16)),
                  SizedBox(height: 0.02*height,),
                  DropdownButton(
                    onChanged: (x){
                      setState(() {
                        dropVal=int.parse(x.toString());
                      });
                    },
                      value: dropVal,
                      elevation: 10,
                      items: const [
                        DropdownMenuItem(
                          value: 1,
                          child: Text("Shopping"),),
                        DropdownMenuItem(
                          value: 2,
                          child: Text("Office"),),
                        DropdownMenuItem(
                          value: 3,
                          child: Text("Restaurant"),),
                        DropdownMenuItem(
                          value: 4,
                          child: Text("Other"),),
                      ]),
                  SizedBox(height: 0.02*height,),
                  MaterialButton(onPressed: ()async{
                    if (_formKey.currentState!.validate()) {
                      if(!isQrActive)
                        {
                          _formKey.currentState!.save();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                          lineNumber = await p1.createLine('x2', qname.text, int.parse(tpuser.text), location.text, categoryList[dropVal]);
                          if(lineNumber==false)
                          {
                            Fluttertoast.showToast(msg: "Could not generate a line");
                          }
                          else
                          {
                            generateQR();
                            //isQrActive=false;
                          }
                        }
                      else
                        {
                          generateQR();
                        }
                    }
                  },elevation: 20,child: Text(isQrActive?"Create New Line":"Generate Queue",style: textStyles.copyWith(color: Colors.white),),color: Colors.black,),
                  isQrActive?Center(
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        QrImage(
                          data: lineNumber,
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                        SizedBox(height: 5,),
                        Text("Scan this QR Code to Join the Queue. Queue Id #: ${lineNumber}",style: textStyles.copyWith(fontSize: 12),),
                        SizedBox(height: 5,),
                        RaisedButton(
                          color: Colors.black,
                          onPressed: (){
                            Navigator.pushNamed(context, '/myqueues');
                          },
                          child: Text("View My Queues",style: textStyles.copyWith(color: Colors.white),),
                        )
                      ],
                    ),
                  ):Container(),]
              ),
            ),
          ),
        ),
      ),
    );
  }
}
