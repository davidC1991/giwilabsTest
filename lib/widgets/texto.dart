import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextoCustomedWidget extends StatelessWidget {
 
 String? text;
 double size;
 Color? color;
 FontWeight? font;
 EdgeInsetsGeometry padding;

 TextoCustomedWidget({required this.text,required this.size, required this.color,this.padding = EdgeInsets.zero, this.font = FontWeight.w300});
 
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: this.padding,
      child: Text(
        this.text!,
        style: TextStyle(color: this.color, fontSize: this.size, fontWeight: this.font,),  
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center
      ),
    );
  }
}
   