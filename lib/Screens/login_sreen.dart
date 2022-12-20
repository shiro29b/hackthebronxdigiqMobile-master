import 'package:flutter/material.dart';
import '../Constants/constants.dart';
import '../Constants/round_button.dart';
import '../PostServices/post_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);



  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final formKey = GlobalKey<FormState>();
  late String password;
  late String userName;
  PostServices a1 = PostServices();


  bool signMeUP(){
    if(formKey.currentState!.validate())
    {
      return true;
    }
    return false;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0,vertical: 100),
          child: Column(
            children: [
              Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image(
                        height: 70,
                        width: 70,
                        image: AssetImage("assets/digiqlogo3.png"),
                      ),
                      SizedBox(
                        height: 70.0,
                      ),

                      Text('Login',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                        ),
                      ),

                      SizedBox(
                        height: 50.0,
                      ),

                      Text('Username',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),

                      TextFormField(

                        textAlign: TextAlign.start,
                        onChanged: (value) {
                          userName=value;
                        },
                        validator: (value){
                          return value!.length >4 ? null : 'Provide more than 4 characters';
                        },
                        decoration: kTextFieldDecoration.copyWith(hintText: 'shiro'),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),

                      SizedBox(
                        height: 15.0,
                      ),

                      Text('Password',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(
                        height: 8.0,
                      ),


                      TextFormField(
                        obscureText: true,
                        textAlign: TextAlign.start,
                        onChanged: (value) {
                          password=value;
                        },
                        validator: (value){
                          return value!.length >6 ? null : 'provide more than 6 characters';
                        },
                        decoration: kTextFieldDecoration.copyWith(hintText: 'password123'),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),

                      RoundedButton(
                        textColor: Colors.white,
                          color: Color(0xffc1272d),
                          title: 'Sign In',
                          onpressed: ()async{
                           bool isCorrect = signMeUP();
                           if (isCorrect){
                             ScaffoldMessenger.of(context).showSnackBar(
                               const SnackBar(content: Text('Please Wait')),
                             );
                             var result = await a1.ApiLogIn(userName, password);
                             print(result);
                             if(result=='success')
                               {
                                 Navigator.of(context)
                                     .pushNamedAndRemoveUntil('/allqueues', (Route<dynamic> route) => false);
                               }
                             Fluttertoast.showToast(msg: result);

                           }

                          }),

                      RoundedButton(
                        textColor: Colors.white,
                        color: Colors.black,
                        title: "Don't Have an account?",
                        onpressed: (){
                          Navigator.pushNamed(context, '/');
                        },
                      )

                    ],
                  )
              ),
            ],
          ),

        ),
      ),

    );;
  }
}
