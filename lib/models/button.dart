import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton({required this.color,required this.text,required this.onPressed});

  final String text;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        elevation: 5,
        color: color,
        borderRadius: BorderRadius.circular(15),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200 ,
          height: 42,
          child: Text(text,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 20)),
        ),
      ),
    );
  }
}
