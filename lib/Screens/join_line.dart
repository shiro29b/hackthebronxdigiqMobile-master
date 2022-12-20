

import 'package:flutter/material.dart';
import 'package:digiq/Constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:digiq/Constants/round_button.dart';
import 'package:digiq/Constants/round_button.dart';
import 'package:digiq/GetServices/get_services.dart';
import 'package:digiq/Screens/login_sreen.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../PostServices/post_services.dart';



class JoinLine extends StatefulWidget {
  const JoinLine({Key? key}) : super(key: key);

  @override
  _JoinLineState createState() => _JoinLineState();
}



class _JoinLineState extends State<JoinLine> {
  GetServices g1 = GetServices();
  PostServices p1 = PostServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Join Queues',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 200,horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                  'Enter Queue ID',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 30
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: PinCodeTextField(
                    appContext: context,
                    length: 4,
                     animationType: AnimationType.fade,
                      onChanged: (value) {
                      var res=value;
                     },



                    onCompleted: (res)async{
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please Wait')),
                      );
                      var joinResult = await p1.ApiJoinLine("", res);
                     // print("$joinResult asdkja");
                      if(joinResult=='You have joined the queue successfully') {
                        Fluttertoast.showToast(msg: joinResult);
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil(
                            '/allqueues', (Route<dynamic> route) => false);
                      }
                      else{
                          Fluttertoast.showToast(msg: joinResult);
                        }


                    },
                ),
              ),
              SizedBox(
                height: 20,
              ),

              Text('or',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                   textStyle: TextStyle(
                     fontSize: 25,
                   ),
                ),
              ),
               SizedBox(
                 height: 40,
               ),

              RoundedButton(
                  color: Color(0xff2b2b2b),
                  title: 'Scan Qr Code',
                  onpressed: (){
                        Navigator.pushNamed(context, '/scanner');
                    },
                  textColor: Colors.white),





            ],
          ),
        ),
      ),
    );
  }
}
