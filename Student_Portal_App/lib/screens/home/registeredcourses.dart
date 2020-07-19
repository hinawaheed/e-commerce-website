import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/drawer_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/shared/constant.dart';

class RegisteredCoursesScreen extends StatelessWidget with DrawerStates{
  
  final AuthService _auth = AuthService();
var Testid = "hello";
 
  Widget GetData(BuildContext context , testid) {
    return SingleChildScrollView(

      child: StreamBuilder(
        stream: Firestore.instance.collection('users').document(testid).snapshots(),
        builder: (context,snapshot) {
           if(!snapshot.hasData) return const Text("Loading...");
           var userDocument = snapshot.data;
           return Column(
            
        children: <Widget>[
          Container(  
            
            

          decoration:BoxDecoration(
            
            border: Border(
            
            ),
           
            ) ,
            padding: const EdgeInsets.all(20.0),
           
            child: Text(" Core Courses " , style: TextStyle(color: Colors.grey[700],fontFamily: 'OpenSans',fontWeight: FontWeight.bold,fontSize: 20.0),),
          ),
          Container(
            decoration:BoxDecoration(
            border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.grey[300]),
            ),
             color: Colors.white,
            ) ,
            padding: const EdgeInsets.all(5.0),
            child: Row(
             children:[
               Expanded(
               child: Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: Text(userDocument['code1'],
                    style: TextStyle(color : Colors.black, fontSize : 14.0),
                  
                    //TextStyle(fontSize: 30),
                    //padding : const EdgeInsets.all(10.0),
                  ),
               ),
               ),
               Container(
                 
                 child: Expanded(
                  
                 child: Text(userDocument['course1'],
                   style: TextStyle(color : Colors.black, fontSize : 14.0),
                    //TextStyle(fontSize: 30),
                    //padding : const EdgeInsets.all(10.0),
                  ),   
             ),
               )
            ]  
            ),
          ),
           
          Container(
            decoration:BoxDecoration(
            border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.grey[200]),
            ),
             color: Colors.white,
            ) ,
            padding: const EdgeInsets.all(5.0),
            child: Row(
             
             children:[
               Expanded(
               child: Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: Text(userDocument['code2'],
                    style: TextStyle(color : Colors.black, fontSize : 14.0),
                    //TextStyle(fontSize: 30),
                    //padding : const EdgeInsets.all(10.0),
                  ),
               ),
               ),
               Expanded(
               child: Text(userDocument['course2'],
                 style: TextStyle(color : Colors.black, fontSize : 14.0),
                  //TextStyle(fontSize: 30),
                  //padding : const EdgeInsets.all(10.0),
                ),   
             )
            ]  
            ),
          ),
          Container(
            decoration:BoxDecoration(
            border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.grey[200]),
            ),
             color: Colors.white,
            ) ,
            padding: const EdgeInsets.all(5.0),
            
            child: Row(
             // padding: const EdgeInsets.all(0.0),
             children:[
               Expanded(
               child: Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: Text(userDocument['code3'],
                   style: TextStyle(color : Colors.black, fontSize : 14.0),
                    //TextStyle(fontSize: 30),
                    //padding : const EdgeInsets.all(10.0),
                  ),
               ),
               ),
               Expanded(
               child: Text(userDocument['course3'],
                 style: TextStyle(color : Colors.black, fontSize : 14.0),
                  //TextStyle(fontSize: 30),
                  //padding : const EdgeInsets.all(10.0),
                ),   
             )
            ]  
            ),
          ),
          Container(
            decoration:BoxDecoration(
            border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.grey[200]),
            ),
             color: Colors.white,
            ) ,
            padding: const EdgeInsets.all(5.0),
            child: Row(
             children:[
               Expanded(
               child: Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: Text(userDocument['code4'],
                    style: TextStyle(color : Colors.black, fontSize : 14.0),
                  ),
               ),
               ),
               Expanded(
               child: Text(userDocument['course4'],
                style: TextStyle(color : Colors.black, fontSize : 14.0),
                ),   
             )
            ]  
            ),
          ),
          Container(
            decoration:BoxDecoration(
            border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.grey[200]),
            ),
             color: Colors.white,
            ) ,
            padding: const EdgeInsets.all(5.0),
            child: Row(
             children:[
               Expanded(
               child: Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: Text(userDocument['lcode'],
                  style: TextStyle(color : Colors.black, fontSize : 14.0),
                  ),
               ),
               ),
               Expanded(
               child: Text(userDocument['lab1'],
                 style: TextStyle(color : Colors.black, fontSize : 14.0),
                ),   
             )
            ]  
            ),
          ),
          Container(
            decoration:BoxDecoration(
              color : Theme.of(context).scaffoldBackgroundColor,
            ) ,
            padding: const EdgeInsets.all(20.0),
            child: Text(" Elective Courses " , style: TextStyle(color: Colors.grey[700],fontFamily: 'OpenSans',fontWeight: FontWeight.bold,fontSize: 20.0),),
          ),
          Container(
            decoration:BoxDecoration(
            border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.grey[200]),
            ),
             color: Colors.white,
            ) ,
            padding: const EdgeInsets.all(10.0),
            child: Row(
             // padding: const EdgeInsets.all(0.0),
             children:[
               Expanded(
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text(userDocument['ecode'],
                    style: TextStyle(color : Colors.black, fontSize : 14.0),
                    //TextStyle(fontSize: 30),
                    //padding : const EdgeInsets.all(10.0),
                  ),
               ),
               ),
               Expanded(
               child: Text(userDocument['elective'],
                  style: TextStyle(color : Colors.black, fontSize : 14.0),
                  //TextStyle(fontSize: 30),
                  //padding : const EdgeInsets.all(10.0),
                ),   
             )
            ]  
            ),
          ),
         
        ]);
        }
        ),
        );
  }

   @override
  Widget build(BuildContext context) {
    
        return Column(children: <Widget>[
          FutureBuilder(
            future: _auth.getUser(),
            builder: (context , snapshot) {
              if(snapshot.connectionState == ConnectionState.done){
                Testid = "${snapshot.data}";
                return GetData(context, Testid);
                //return Text("${snapshot.data}");
              }else{
                return CircularProgressIndicator();
              }
            },
          )
        ]);
  }

}