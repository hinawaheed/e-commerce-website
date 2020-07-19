import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/drawer_bloc.dart';
import 'package:flutter_app/screens/home/home.dart';
import 'package:flutter_app/shared/wrapper.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/models/user.dart';

void main() => runApp(Hello());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[200],
        primaryColor: Colors.grey[200],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      home: BlocProvider<DrawerBloc>(
        create: (context) => DrawerBloc(),
        child: Home(),
      ),
    );
  }
}
class Hello extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
        ),
    );
  }
}
