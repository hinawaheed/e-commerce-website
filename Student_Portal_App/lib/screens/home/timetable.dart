import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/drawer_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/shared/constant.dart';
class FirstPage extends StatelessWidget{
  @override
  Widget build(BuildContext context,  ) {
     return SingleChildScrollView(

      child: StreamBuilder(
        stream: Firestore.instance.collection('timetable').document('17k').collection('monday').document('classes').snapshots(),
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
           
            child: Text( "MONDAY", style: TextStyle(color: Colors.grey[700],fontFamily: 'OpenSans',fontWeight: FontWeight.bold,fontSize: 20.0),),
          ),
          
Center(
            child: Container(
              constraints: BoxConstraints(
          maxHeight: 100.0,
          maxWidth: 370.0,
          minWidth: 300.0,
          minHeight: 70.0
      ),
              decoration:BoxDecoration(
              border: Border(
              bottom: BorderSide(width: 12.0, color: Colors.grey[200]),
              ),
               color: Colors.lightBlue[900],
              ) ,
              
              padding: const EdgeInsets.all(5.0),
              child: Row(
                
               children:[
                 Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(10.0),
                 child: ListTile(
               ),), ),    Padding(
                      padding: EdgeInsets.only(top:15,left: 0,right: 70,bottom: 10), 
                    child: Column(
                      children: <Widget>[  
                        Text(userDocument['course_code3']+"   " +userDocument['course_name3'],
                 style: TextStyle(color : Colors.white, fontSize : 16),),
          Center(
                    child: Container(
                            height: 1.0,
                            width: 230,
                            color : Colors.white,
                           padding: EdgeInsets.only(top:20),
                          ),
                  ),
         Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(userDocument['room3']+"  " +userDocument['teacher3']+"  " +userDocument['time3'],style: TextStyle(fontFamily: 'DancingScript',color : Colors.white, fontSize : 16),),
           )],),
                  ),]  ),
                   
                  
                  ),),Center(
            child: Container(
              constraints: BoxConstraints(
          maxHeight: 100.0,
          maxWidth: 370.0,
          minWidth: 300.0,
          minHeight: 70.0
      ),
              decoration:BoxDecoration(
              border: Border(
              bottom: BorderSide(width: 12.0, color: Colors.grey[200]),
              ),
               color: Colors.lightBlue[900],
              ) ,
              
              padding: const EdgeInsets.all(5.0),
              child: Row(
                
               children:[
                 Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(10.0),
                 child: ListTile(
               ),), ),    Padding(
                      padding: EdgeInsets.only(top:15,left: 0,right: 70,bottom: 10), 
                    child: Column(
                      children: <Widget>[  
                        Text(userDocument['course_code4']+"  " +userDocument['course_name4'],
                 style: TextStyle(color : Colors.white, fontSize : 16),),
          Center(
                    child: Container(
                            height: 1.0,
                            width: 230,
                            color : Colors.white,
                           padding: EdgeInsets.only(top:20),
                          ),
                  ),
         Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(userDocument['room4']+"   " +userDocument['teacher4']+"   " +userDocument['time4'],style: TextStyle(fontFamily: 'DancingScript',color : Colors.white, fontSize : 16),),
           )],),
                  ),]  ),
                   
                  
                  ),),
Center(
            child: Container(
              constraints: BoxConstraints(
          maxHeight: 100.0,
          maxWidth: 370.0,
          minWidth: 300.0,
          minHeight: 70.0
      ),
              decoration:BoxDecoration(
              border: Border(
              bottom: BorderSide(width: 12.0, color: Colors.grey[200]),
              ),
               color: Colors.lightBlue[900],
              ) ,
              
              padding: const EdgeInsets.all(5.0),
              child: Row(
                
               children:[
                 Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(10.0),
                 child: ListTile(
               ),), ),    Padding(
                      padding: EdgeInsets.only(top:15,left: 0,right: 70,bottom: 10), 
                    child: Column(
                      children: <Widget>[  
                        Text(userDocument['course_code5']+"  " +userDocument['course_name5'],
                 style: TextStyle(color : Colors.white, fontSize : 16),),
          Center(
                    child: Container(
                            height: 1.0,
                            width: 230,
                            color : Colors.white,
                           padding: EdgeInsets.only(top:20),
                          ),
                  ),
         Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(userDocument['room5']+"   " +userDocument['teacher5']+"   " +userDocument['time4'],style: TextStyle(fontFamily: 'DancingScript',color : Colors.white, fontSize : 16),),
           )],),
                  ),]  ),
                   
                  
                  ),),
                  Center(
            child: Container(
              constraints: BoxConstraints(
          maxHeight: 100.0,
          maxWidth: 370.0,
          minWidth: 300.0,
          minHeight: 70.0
      ),
              decoration:BoxDecoration(
              border: Border(
              bottom: BorderSide(width: 12.0, color: Colors.grey[200]),
              ),
               color: Colors.lightBlue[900],
              ) ,
              
              padding: const EdgeInsets.all(5.0),
              child: Row(
                
               children:[
                 Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(10.0),
                 child: ListTile(
               ),), ),    Padding(
                      padding: EdgeInsets.only(top:15,left: 0,right: 70,bottom: 10), 
                    child: Column(
                      children: <Widget>[  
                        Text(userDocument['course_code6']+"   " +userDocument['course_name6'],
                 style: TextStyle(color : Colors.white, fontSize : 16),),
          Center(
                    child: Container(
                            height: 1.0,
                            width: 230,
                            color : Colors.white,
                           padding: EdgeInsets.only(top:20),
                          ),
                  ),
         Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(userDocument['room6']+"   " +userDocument['teacher6']+"  " +userDocument['time6'],style: TextStyle(fontFamily: 'DancingScript',color : Colors.white, fontSize : 16),),
           )],),
                  ),]  ),
                   
                  
                  ),),
                  Center(
          child: Container(
              constraints: BoxConstraints(
          maxHeight: 100.0,
          maxWidth: 370.0,
          minWidth: 300.0,
          minHeight: 80.0
      ),
              alignment: AlignmentDirectional(10.0, 10.0),
              decoration:BoxDecoration(
           border: Border(
              bottom: BorderSide(width: 12.0, color: Colors.grey[200]),
              ),
               color: Colors.lightBlue[900],
              ) ,
              padding: const EdgeInsets.all(5.0),
              child: Row(
               children:[
                 Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(10.0),
                   
                 child: ListTile() ,
                  ),),
               Padding(
                      padding: EdgeInsets.only(top:15,left: 0,right: 70,bottom: 10), 
                    child: Column(
                      children: <Widget>[  
                        Text(userDocument['course_code1']+"  " +userDocument['course_name1'],
                 style: TextStyle(color : Colors.white, fontSize : 16),),
          Center(
                    child: Container(
                            height: 1.0,
                            width: 220,
                            color : Colors.white,
                           padding: EdgeInsets.only(top:20),
                          ),
                  ),
         Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(userDocument['room1']+"    " +userDocument['teacher1']+"   " +userDocument['time1'],style: TextStyle(fontFamily: 'DancingScript',color : Colors.white, fontSize : 16),),
           )],),
                  ),]  ),
                   
                  
                  ),),
 Center(
            child: Container(
              constraints: BoxConstraints(
          maxHeight: 100.0,
          maxWidth: 370.0,
          minWidth: 300.0,
          minHeight: 70.0
      ),
              decoration:BoxDecoration(
              border: Border(
              bottom: BorderSide(width: 12.0, color: Colors.grey[200]),
              ),
               color: Colors.lightBlue[900],
              ) ,
              
              padding: const EdgeInsets.all(5.0),
              child: Row(
                
               children:[
                 Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(10.0),
                 child: ListTile(
               ),), ),    Padding(
                      padding: EdgeInsets.only(top:15,left: 0,right: 70,bottom: 10), 
                    child: Column(
                      children: <Widget>[  
                        Text(userDocument['course_code2']+"   " +userDocument['course_name2'],
                 style: TextStyle(color : Colors.white, fontSize : 16),),
          Center(
                    child: Container(
                            height: 1.0,
                            width: 230,
                            color : Colors.white,
                           padding: EdgeInsets.only(top:20),
                          ),
                  ),
         Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(userDocument['room2']+"  " +userDocument['teacher2']+"  " +userDocument['time2'],style: TextStyle(fontFamily: 'DancingScript',color : Colors.white, fontSize : 16),),
           )],),
                  ),]  ),
                   
                  
                  ),),
                          ]);} ), );}}

class SecondPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      child: StreamBuilder(
        stream: Firestore.instance.collection('timetable').document('17k').collection('tuesday').document('classes').snapshots(),
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
           
            child: Text( "TUESDAY", style: TextStyle(color: Colors.grey[700],fontFamily: 'OpenSans',fontWeight: FontWeight.bold,fontSize: 20.0),),
          ),
         Center(
          child: Container(
              constraints: BoxConstraints(
          maxHeight: 100.0,
          maxWidth: 370.0,
          minWidth: 300.0,
          minHeight: 80.0
      ),
              alignment: AlignmentDirectional(10.0, 10.0),
              decoration:BoxDecoration(
           border: Border(
              bottom: BorderSide(width: 12.0, color: Colors.grey[200]),
              ),
               color: Colors.lightBlue[900],
              ) ,
              padding: const EdgeInsets.all(5.0),
              child: Row(
               children:[
                 Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(10.0),
                   
                 child: ListTile() ,
                  ),),
               Padding(
                      padding: EdgeInsets.only(top:15,left: 0,right: 70,bottom: 10), 
                    child: Column(
                      children: <Widget>[  
                        Text(userDocument['course_code3']+"  " +userDocument['course_name3'],
                 style: TextStyle(color : Colors.white, fontSize : 16),),
          Center(
                    child: Container(
                            height: 1.0,
                            width: 220,
                            color : Colors.white,
                           padding: EdgeInsets.only(top:20),
                          ),
                  ),
         Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(userDocument['room3']+"  " +userDocument['teacher3']+"  " +userDocument['time3'],style: TextStyle(fontFamily: 'DancingScript',color : Colors.white, fontSize : 16),),
           )],),
                  ),]  ),
                   
                  
                  ),),
 Center(
            child: Container(
              constraints: BoxConstraints(
          maxHeight: 100.0,
          maxWidth: 370.0,
          minWidth: 300.0,
          minHeight: 70.0
      ),
              decoration:BoxDecoration(
              border: Border(
              bottom: BorderSide(width: 12.0, color: Colors.grey[200]),
              ),
               color: Colors.lightBlue[900],
              ) ,
              
              padding: const EdgeInsets.all(5.0),
              child: Row(
                
               children:[
                 Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(10.0),
                 child: ListTile(
               ),), ),    Padding(
                      padding: EdgeInsets.only(top:15,left: 0,right: 70,bottom: 10), 
                    child: Column(
                      children: <Widget>[  
                        Text(userDocument['course_code2']+"  " +userDocument['course_name2'],
                 style: TextStyle(color : Colors.white, fontSize : 16),),
          Center(
                    child: Container(
                            height: 1.0,
                            width: 230,
                            color : Colors.white,
                           padding: EdgeInsets.only(top:20),
                          ),
                  ),
         Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(userDocument['room2']+"    " +userDocument['teacher2']+"   " +userDocument['time2'],style: TextStyle(fontFamily: 'DancingScript',color : Colors.white, fontSize : 16),),
           )],),
                  ),]  ),
                   
                  
                  ),),
                     Center(
          child: Container(
              constraints: BoxConstraints(
          maxHeight: 100.0,
          maxWidth: 370.0,
          minWidth: 300.0,
          minHeight: 80.0
      ),
              alignment: AlignmentDirectional(10.0, 10.0),
              decoration:BoxDecoration(
           border: Border(
              bottom: BorderSide(width: 12.0, color: Colors.grey[200]),
              ),
               color: Colors.lightBlue[900],
              ) ,
              padding: const EdgeInsets.all(5.0),
              child: Row(
               children:[
                 Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(10.0),
                   
                 child: ListTile() ,
                  ),),
               Padding(
                      padding: EdgeInsets.only(top:15,left: 0,right: 70,bottom: 10), 
                    child: Column(
                      children: <Widget>[  
                        Text(userDocument['course_code4']+"  " +userDocument['course_name4'],
                 style: TextStyle(color : Colors.white, fontSize : 16),),
          Center(
                    child: Container(
                            height: 1.0,
                            width: 220,
                            color : Colors.white,
                           padding: EdgeInsets.only(top:20),
                          ),
                  ),
         Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(userDocument['room4']+"   " +userDocument['teacher4']+"   " +userDocument['time4'],style: TextStyle(fontFamily: 'DancingScript',color : Colors.white, fontSize : 16),),
           )],),
                  ),]  ),
                   
                  
                  ),),
 Center(
            child: Container(
              constraints: BoxConstraints(
          maxHeight: 100.0,
          maxWidth: 370.0,
          minWidth: 300.0,
          minHeight: 70.0
      ),
              decoration:BoxDecoration(
              border: Border(
              bottom: BorderSide(width: 12.0, color: Colors.grey[200]),
              ),
               color: Colors.lightBlue[900],
              ) ,
              
              padding: const EdgeInsets.all(5.0),
              child: Row(
                
               children:[
                 Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(10.0),
                 child: ListTile(
               ),), ),    Padding(
                      padding: EdgeInsets.only(top:15,left: 0,right: 70,bottom: 10), 
                    child: Column(
                      children: <Widget>[  
                        Text(userDocument['course_code1']+"  " +userDocument['course_name1'],
                 style: TextStyle(color : Colors.white, fontSize : 16),),
          Center(
                    child: Container(
                            height: 1.0,
                            width: 230,
                            color : Colors.white,
                           padding: EdgeInsets.only(top:20),
                          ),
                  ),
         Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(userDocument['room1']+"   " +userDocument['teacher1']+"   " +userDocument['time1'],style: TextStyle(fontFamily: 'DancingScript',color : Colors.white, fontSize : 16),),
           )],),
                  ),]  ),
                   
                  
                  ),),
 

                         ]);} ), );
  }
}

class ThirdPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      child: StreamBuilder(
        stream: Firestore.instance.collection('timetable').document('17k').collection('wednesday').document('classes').snapshots(),
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
           
            child: Text( "WEDNESDAY", style: TextStyle(color: Colors.grey[700],fontFamily: 'OpenSans',fontWeight: FontWeight.bold,fontSize: 20.0),),
          ),
          Center(
            child: Container(
              constraints: BoxConstraints(
          maxHeight: 100.0,
          maxWidth: 370.0,
          minWidth: 300.0,
          minHeight: 70.0
      ),
              decoration:BoxDecoration(
              border: Border(
              bottom: BorderSide(width: 12.0, color: Colors.grey[200]),
              ),
               color: Colors.lightBlue[900],
              ) ,
              
              padding: const EdgeInsets.all(5.0),
              child: Row(
                
               children:[
                 Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(10.0),
                 child: ListTile(
               ),), ),    Padding(
                      padding: EdgeInsets.only(top:15,left: 0,right: 70,bottom: 10), 
                    child: Column(
                      children: <Widget>[  
                        Text(userDocument['course_code1']+"  " +userDocument['course_name1'],
                 style: TextStyle(color : Colors.white, fontSize : 16),),
          Center(
                    child: Container(
                            height: 1.0,
                            width: 230,
                            color : Colors.white,
                           padding: EdgeInsets.only(top:20),
                          ),
                  ),
         Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(userDocument['room1']+"   " +userDocument['teacher1']+"   " +userDocument['time1'],style: TextStyle(fontFamily: 'DancingScript',color : Colors.white, fontSize : 16),),
           )],),
                  ),]  ),
                   
                  
                  ),),
                   Center(
          child: Container(
              constraints: BoxConstraints(
          maxHeight: 100.0,
          maxWidth: 370.0,
          minWidth: 300.0,
          minHeight: 80.0
      ),
              alignment: AlignmentDirectional(10.0, 10.0),
              decoration:BoxDecoration(
           border: Border(
              bottom: BorderSide(width: 12.0, color: Colors.grey[200]),
              ),
               color: Colors.lightBlue[900],
              ) ,
              padding: const EdgeInsets.all(5.0),
              child: Row(
               children:[
                 Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(10.0),
                   
                 child: ListTile() ,
                  ),),
               Padding(
                      padding: EdgeInsets.only(top:15,left: 0,right: 70,bottom: 10), 
                    child: Column(
                      children: <Widget>[  
                        Text(userDocument['course_code2']+"  " +userDocument['course_name2'],
                 style: TextStyle(color : Colors.white, fontSize : 16),),
          Center(
                    child: Container(
                            height: 1.0,
                            width: 220,
                            color : Colors.white,
                           padding: EdgeInsets.only(top:20),
                          ),
                  ),
         Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(userDocument['room2']+"   " +userDocument['teacher2']+"   " +userDocument['time2'],style: TextStyle(fontFamily: 'DancingScript',color : Colors.white, fontSize : 16),),
           )],),
                  ),]  ),
                   
                  
                  ),),
       Center(
          child: Container(
              constraints: BoxConstraints(
          maxHeight: 100.0,
          maxWidth: 370.0,
          minWidth: 300.0,
          minHeight: 80.0
      ),
              alignment: AlignmentDirectional(10.0, 10.0),
              decoration:BoxDecoration(
           border: Border(
              bottom: BorderSide(width: 12.0, color: Colors.grey[200]),
              ),
               color: Colors.lightBlue[900],
              ) ,
              padding: const EdgeInsets.all(5.0),
              child: Row(
               children:[
                 Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(10.0),
                   
                 child: ListTile() ,
                  ),),
               Padding(
                      padding: EdgeInsets.only(top:15,left: 0,right: 70,bottom: 10), 
                    child: Column(
                      children: <Widget>[  
                        Text(userDocument['course_code4']+"  " +userDocument['course_name4'],
                 style: TextStyle(color : Colors.white, fontSize : 16),),
          Center(
                    child: Container(
                            height: 1.0,
                            width: 220,
                            color : Colors.white,
                           padding: EdgeInsets.only(top:20),
                          ),
                  ),
         Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(userDocument['room4']+"   " +userDocument['teacher4']+"   " +userDocument['time4'],style: TextStyle(fontFamily: 'DancingScript',color : Colors.white, fontSize : 16),),
           )],),
                  ),]  ),
                   
                  
                  ),),
                    Center(
          child: Container(
              constraints: BoxConstraints(
          maxHeight: 100.0,
          maxWidth: 370.0,
          minWidth: 300.0,
          minHeight: 80.0
      ),
              alignment: AlignmentDirectional(10.0, 10.0),
              decoration:BoxDecoration(
           border: Border(
              bottom: BorderSide(width: 12.0, color: Colors.grey[200]),
              ),
               color: Colors.lightBlue[900],
              ) ,
              padding: const EdgeInsets.all(5.0),
              child: Row(
               children:[
                 Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(10.0),
                   
                 child: ListTile() ,
                  ),),
               Padding(
                      padding: EdgeInsets.only(top:15,left: 0,right: 70,bottom: 10), 
                    child: Column(
                      children: <Widget>[  
                        Text(userDocument['course_code3']+"  " +userDocument['course_name3'],
                 style: TextStyle(color : Colors.white, fontSize : 16),),
          Center(
                    child: Container(
                            height: 1.0,
                            width: 220,
                            color : Colors.white,
                           padding: EdgeInsets.only(top:20),
                          ),
                  ),
         Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(userDocument['room3']+"   " +userDocument['teacher3']+"   " +userDocument['time4'],style: TextStyle(fontFamily: 'DancingScript',color : Colors.white, fontSize : 16),),
           )],),
                  ),]  ),
                   
                  
                  ),),
                            Center(
          child: Container(
              constraints: BoxConstraints(
          maxHeight: 100.0,
          maxWidth: 370.0,
          minWidth: 300.0,
          minHeight: 80.0
      ),
              alignment: AlignmentDirectional(10.0, 10.0),
              decoration:BoxDecoration(
           border: Border(
              bottom: BorderSide(width: 12.0, color: Colors.grey[200]),
              ),
               color: Colors.lightBlue[900],
              ) ,
              padding: const EdgeInsets.all(5.0),
              child: Row(
               children:[
                 Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(10.0),
                   
                 child: ListTile() ,
                  ),),
               Padding(
                      padding: EdgeInsets.only(top:15,left: 0,right: 70,bottom: 10), 
                    child: Column(
                      children: <Widget>[  
                        Text(userDocument['course_code5']+"  " +userDocument['course_name5'],
                 style: TextStyle(color : Colors.white, fontSize : 16),),
          Center(
                    child: Container(
                            height: 1.0,
                            width: 220,
                            color : Colors.white,
                           padding: EdgeInsets.only(top:20),
                          ),
                  ),
         Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(userDocument['room5']+"  " +userDocument['teacher5']+"  " +userDocument['time4'],style: TextStyle(fontFamily: 'DancingScript',color : Colors.white, fontSize : 16),),
           )],),
                  ),]  ),
                   
                  
                  ),),

                         ]);}
                          ), );
  }
}

class FourthPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return SingleChildScrollView(

      child: StreamBuilder(
        stream: Firestore.instance.collection('timetable').document('17k').collection('thursday').document('classes').snapshots(),
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
           
            child: Text( "THURSDAY", style: TextStyle(color: Colors.grey[700],fontFamily: 'OpenSans',fontWeight: FontWeight.bold,fontSize: 20.0),),
          ),
                    Center(
          child: Container(
              constraints: BoxConstraints(
          maxHeight: 100.0,
          maxWidth: 370.0,
          minWidth: 300.0,
          minHeight: 80.0
      ),
              alignment: AlignmentDirectional(10.0, 10.0),
              decoration:BoxDecoration(
           border: Border(
              bottom: BorderSide(width: 12.0, color: Colors.grey[200]),
              ),
               color: Colors.lightBlue[900],
              ) ,
              padding: const EdgeInsets.all(5.0),
              child: Row(
               children:[
                 Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(10.0),
                   
                 child: ListTile() ,
                  ),),
               Padding(
                      padding: EdgeInsets.only(top:15,left: 0,right: 70,bottom: 10), 
                    child: Column(
                      children: <Widget>[  
                        Text(userDocument['course_code1']+"  " +userDocument['course_name1'],
                 style: TextStyle(color : Colors.white, fontSize : 16),),
          Center(
                    child: Container(
                            height: 1.0,
                            width: 220,
                            color : Colors.white,
                           padding: EdgeInsets.only(top:20),
                          ),
                  ),
         Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(userDocument['room1']+"   " +userDocument['teacher1']+"   " +userDocument['time1'],style: TextStyle(fontFamily: 'DancingScript',color : Colors.white, fontSize : 16),),
           )],),
                  ),]  ),
                   
                  
                  ),),
           Center(
          child: Container(
              constraints: BoxConstraints(
          maxHeight: 100.0,
          maxWidth: 370.0,
          minWidth: 300.0,
          minHeight: 80.0
      ),
              alignment: AlignmentDirectional(10.0, 10.0),
              decoration:BoxDecoration(
           border: Border(
              bottom: BorderSide(width: 12.0, color: Colors.grey[200]),
              ),
               color: Colors.lightBlue[900],
              ) ,
              padding: const EdgeInsets.all(5.0),
              child: Row(
               children:[
                 Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(10.0),
                   
                 child: ListTile() ,
                  ),),
               Padding(
                      padding: EdgeInsets.only(top:15,left: 0,right: 70,bottom: 10), 
                    child: Column(
                      children: <Widget>[  
                        Text(userDocument['course_code3']+"  " +userDocument['course_name3'],
                 style: TextStyle(color : Colors.white, fontSize : 16),),
          Center(
                    child: Container(
                            height: 1.0,
                            width: 220,
                            color : Colors.white,
                           padding: EdgeInsets.only(top:20),
                          ),
                  ),
         Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(userDocument['room3']+"  " +userDocument['teacher3']+"  " +userDocument['time2'],style: TextStyle(fontFamily: 'DancingScript',color : Colors.white, fontSize : 16),),
           )],),
                  ),]  ),
                   
                  
                  ),),
          Center(
          child: Container(
              constraints: BoxConstraints(
          maxHeight: 100.0,
          maxWidth: 370.0,
          minWidth: 300.0,
          minHeight: 80.0
      ),
              alignment: AlignmentDirectional(10.0, 10.0),
              decoration:BoxDecoration(
           border: Border(
              bottom: BorderSide(width: 12.0, color: Colors.grey[200]),
              ),
               color: Colors.lightBlue[900],
              ) ,
              padding: const EdgeInsets.all(5.0),
              child: Row(
               children:[
                 Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(10.0),
                   
                 child: ListTile() ,
                  ),),
               Padding(
                      padding: EdgeInsets.only(top:15,left: 0,right: 70,bottom: 10), 
                    child: Column(
                      children: <Widget>[  
                        Text(userDocument['course_code2']+"  " +userDocument['course_name2'],
                 style: TextStyle(color : Colors.white, fontSize : 16),),
          Center(
                    child: Container(
                            height: 1.0,
                            width: 220,
                            color : Colors.white,
                           padding: EdgeInsets.only(top:20),
                          ),
                  ),
         Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(userDocument['room2']+"  " +userDocument['teacher2']+"  " +userDocument['time2'],style: TextStyle(fontFamily: 'DancingScript',color : Colors.white, fontSize : 16),),
           )],),
                  ),]  ),
                   
                  
                  ),),          Center(
          child: Container(
              constraints: BoxConstraints(
          maxHeight: 100.0,
          maxWidth: 370.0,
          minWidth: 300.0,
          minHeight: 80.0
      ),
              alignment: AlignmentDirectional(10.0, 10.0),
              decoration:BoxDecoration(
           border: Border(
              bottom: BorderSide(width: 12.0, color: Colors.grey[200]),
              ),
               color: Colors.lightBlue[900],
              ) ,
              padding: const EdgeInsets.all(5.0),
              child: Row(
               children:[
                 Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(10.0),
                   
                 child: ListTile() ,
                  ),),
               Padding(
                      padding: EdgeInsets.only(top:15,left: 0,right: 70,bottom: 10), 
                    child: Column(
                      children: <Widget>[  
                        Text(userDocument['course_code4']+"  " +userDocument['course_name4'],
                 style: TextStyle(color : Colors.white, fontSize : 16),),
          Center(
                    child: Container(
                            height: 1.0,
                            width: 220,
                            color : Colors.white,
                           padding: EdgeInsets.only(top:20),
                          ),
                  ),
         Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(userDocument['room4']+"  " +userDocument['teacher4']+"  " +userDocument['time4'],style: TextStyle(fontFamily: 'DancingScript',color : Colors.white, fontSize : 16),),
           )],),
                  ),]  ),
                   
                  
                  ),),
          Center(
          child: Container(
              constraints: BoxConstraints(
          maxHeight: 100.0,
          maxWidth: 370.0,
          minWidth: 300.0,
          minHeight: 80.0
      ),
              alignment: AlignmentDirectional(10.0, 10.0),
              decoration:BoxDecoration(
           border: Border(
              bottom: BorderSide(width: 12.0, color: Colors.grey[200]),
              ),
               color: Colors.lightBlue[900],
              ) ,
              padding: const EdgeInsets.all(5.0),
              child: Row(
               children:[
                 Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(10.0),
                   
                 child: ListTile() ,
                  ),),
               Padding(
                      padding: EdgeInsets.only(top:15,left: 0,right: 70,bottom: 10), 
                    child: Column(
                      children: <Widget>[  
                        Text(userDocument['course_code5']+"  " +userDocument['course_name5'],
                 style: TextStyle(color : Colors.white, fontSize : 16),),
          Center(
                    child: Container(
                            height: 1.0,
                            width: 220,
                            color : Colors.white,
                           padding: EdgeInsets.only(top:20),
                          ),
                  ),
         Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(userDocument['room5']+"   " +userDocument['teacher5']+"   " +userDocument['time5'],style: TextStyle(fontFamily: 'DancingScript',color : Colors.white, fontSize : 16),),
           )],),
                  ),]  ),
                   
                  
                  ),),
                            Center(
          child: Container(
              constraints: BoxConstraints(
          maxHeight: 100.0,
          maxWidth: 370.0,
          minWidth: 300.0,
          minHeight: 80.0
      ),
              alignment: AlignmentDirectional(10.0, 10.0),
              decoration:BoxDecoration(
           border: Border(
              bottom: BorderSide(width: 12.0, color: Colors.grey[200]),
              ),
               color: Colors.lightBlue[900],
              ) ,
              padding: const EdgeInsets.all(5.0),
              child: Row(
               children:[
                 Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(10.0),
                   
                 child: ListTile() ,
                  ),),
               Padding(
                      padding: EdgeInsets.only(top:15,left: 0,right: 70,bottom: 10), 
                    child: Column(
                      children: <Widget>[  
                        Text(userDocument['course_code6']+"  " +userDocument['course_name6'],
                 style: TextStyle(color : Colors.white, fontSize : 16),),
          Center(
                    child: Container(
                            height: 1.0,
                            width: 220,
                            color : Colors.white,
                           padding: EdgeInsets.only(top:20),
                          ),
                  ),
         Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(userDocument['room6']+"  " +userDocument['teacher6']+"  " +userDocument['time6'],style: TextStyle(fontFamily: 'DancingScript',color : Colors.white, fontSize : 16),),
           )],),
                  ),]  ),
                   
                  
                  ),),
                         ]);} ), );
  }
}


class TimeTableScreen extends StatelessWidget with DrawerStates{

 int _seletedItem = 0;
  var _pages = [FirstPage(), SecondPage(), ThirdPage(), FourthPage(), ];
  var _pageController = PageController();

    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> _days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];
  String dayName;
  TimeOfDay startTime;
  TimeOfDay endTime;
  String activity;

 final AuthService _auth = AuthService();
var Testid = "hello";
 
 
  Widget GetData(BuildContext context , testid) {
    
  }

   @override
  Widget build(BuildContext context) {

     return Scaffold(
      
      body: PageView(
        children: _pages,
        onPageChanged: (index) {
         
            _seletedItem = index;
         
        },
        controller: _pageController,
      ),
   
    );

    
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