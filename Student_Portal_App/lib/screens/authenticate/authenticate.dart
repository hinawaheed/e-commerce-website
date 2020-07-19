import 'package:flutter/material.dart';
import 'package:flutter_app/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate>
    with SingleTickerProviderStateMixin {
bool showSignIn = true;

  @override
  Widget build(BuildContext context) {
  return SignIn();
  }
}