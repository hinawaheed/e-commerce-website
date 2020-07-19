
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/resources/firebase_repo.dart';
import 'package:flutter_app/screens/home/drawer_bloc.dart';
import 'package:flutter_app/services/auth.dart';

class UserProfileScreen extends StatefulWidget with DrawerStates {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}
String currentUserid = 'hello';
class _UserProfileScreenState extends State<UserProfileScreen> {
 

final AuthService _auth = AuthService();
var Testid = "hello";
final FirebaseRepository _repository = FirebaseRepository();
  dynamic data;
  static final FirebaseAuth auth = FirebaseAuth.instance;
  Future<dynamic> getData() async {
        final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;

    final DocumentReference document =   Firestore.instance.collection('users').document(currentUserid);

    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
     setState(() {
       data =snapshot.data;
     });
    });
 }
 
 @override
  void initState(){
    super.initState();
    getData();
    _repository.getCurrentUser().then((user){
      setState(() {
        currentUserid = user.uid;
      });
    });
  }
  
  Widget _greenColors() {
    return Positioned(
      top: 0,
      child: Container(
        
      ),
    );
  }

  Widget _getInfo(BuildContext context , testid) {
    getData();
    return Positioned(
      top: 100,
      child: Container(
        margin: const EdgeInsets.all(20),
        height: 260,
        width : 370,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[600],
                  offset: Offset(4.0, 4.0),
                  blurRadius: 15.0,
                  spreadRadius: 0.7),
              BoxShadow(
                  color: Colors.white,
                  offset: Offset(-4.0, -4.0, ),
                  blurRadius: 15.0,
                  spreadRadius: 1.0),
            ],
             gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.grey[200],
                Colors.grey[300],
                Colors.grey[200],
                Colors.grey[200],
              ],
                stops: [
                  0.1,
                  0.3,
                  0.8,
                  1
                ]
             ),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("USER INFORMATION",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  
                  Text(data['name']),
                  SizedBox(
                    width: 20,
                  ),
                  Text(data['id']),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Email :",
                  style: TextStyle(color: Color(0xFF527DAA),fontWeight: FontWeight.bold, fontSize: 15)),
                  Center(
                    child: SizedBox(
                      width: 20,
                      
                    ),
                  ),
                  Text(data['email'],style: TextStyle(color: Color(0xFF527DAA), fontWeight: FontWeight.bold, fontSize: 15,)),
                  
                  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userAdress() {
    return Positioned(
      top: 380,
      child: Container(
        margin: EdgeInsets.all(20),
        height: 200,
        width : 370,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20),
             boxShadow: [
              BoxShadow(
                  color: Colors.grey[600],
                  offset: Offset(4.0, 4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0),
              BoxShadow(
                  color: Colors.white,
                  offset: Offset(-4.0, -4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0),
            ],
             gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.grey[200],
                Colors.grey[300],
                Colors.grey[200],
                Colors.grey[300],
              ],
                stops: [
                  0.1,
                  0.3,
                  0.8,
                  1
                ]
             ),

            ),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "USER DETAILS",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("University"),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Fast NUCES"),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("City:"),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Karachi, Pakistan"),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("District Province:"),
                  SizedBox(
                    width: 10,
                  ),
                  Text("East Sindh"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            _greenColors(),
            _getInfo(context, Testid),
            _userAdress(),
          ],
        ),
      ),
    );
  }
}
