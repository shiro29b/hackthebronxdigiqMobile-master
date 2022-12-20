import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({ required this.color,required this.title,required this.onpressed,required this.textColor});

  final Color color;
  final String title;
  final Function onpressed;
   final Color textColor;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(12.0),
        child: MaterialButton(
          minWidth: 150,
          height: 50.0,
          child: Text(title,
          style: TextStyle(
            fontSize: 15,
            color: Colors.white
          ),
          ),
          onPressed: (){
            onpressed();
          },
        ),
      ),
    );
  }
}
