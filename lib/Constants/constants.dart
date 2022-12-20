import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
TextStyle textStyles = GoogleFonts.poppins(color: Colors.black);
int z = 0;
const kTextFieldDecoration =  InputDecoration(
  hintStyle: TextStyle(color: Colors.black54),
  contentPadding:
  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Colors.black, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Colors.black, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
);
Future<String?>getToken({required String key})async
{
  final prefs = await SharedPreferences.getInstance();
  final getkey = '$key';
  final value = prefs.getString(getkey)?? null;
  print("THIS IS TOKEN IN SPREF");
  print(value);
  return value;
}
deleteLocalKey(String key) async {
  final prefs = await SharedPreferences.getInstance();
  final finalKey = '$key';
  prefs.remove(finalKey);
  prefs.clear();
}
const kMainColor= Color(0xff803BC9);
int idx = 0;
List<String>categoryList = [" ","Shopping","Office","Restaurant","Other"];