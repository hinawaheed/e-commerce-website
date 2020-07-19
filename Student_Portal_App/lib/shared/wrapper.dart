import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);
    if(user == null ){
      return Authenticate(); 
    } else {
      return MyApp();
    }

     
  }
}