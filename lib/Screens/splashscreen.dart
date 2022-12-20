import 'dart:async';

import 'package:digiq/Screens/sign_up.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                const SignUpScreen()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Image(
          height: 200,
          width: 200,
          image: AssetImage("assets/digiqlogo1.png"),
        ),
      ),),
    );
  }
}
