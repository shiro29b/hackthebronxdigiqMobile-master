
import 'package:digiq/Screens/all_queues.dart';
import 'package:digiq/Screens/createlinepage.dart';
import 'package:digiq/Screens/scanner_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/join_line.dart';
import 'Screens/splashscreen.dart';
import 'Constants/constants.dart';
import 'Screens/sign_up.dart';
import 'Screens/login_sreen.dart';
import 'Screens/my_queues.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  var x = await getToken(key: 'name');
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: x==null?('/splash'):('/allqueues'),
        routes: {
          '/splash':(context)=> SplashScreen(),
          '/':(context)=>SignUpScreen(),
          '/login':(context)=> LoginScreen(),
          '/allqueues':(context)=> MainMenu(),
          '/myqueues': (context)=> MyQueues(),
          '/createline':(context)=>CreateLinePage(),
          '/joinlines':(context)=>JoinLine(),
          '/scanner':(context)=>Scanner()
        },
       // home: x == null ? SignUpScreen() : MainMenu(),
      )
  );
}
