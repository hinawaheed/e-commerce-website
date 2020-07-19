import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  @override

  const DrawerItem({Key key , this.text , this.onPressed}) : super(key: key);

  final String text;
  final Function onPressed;

  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed, 
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      );
  }
}