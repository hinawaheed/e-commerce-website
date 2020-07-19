

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/drawer_bloc.dart';
import 'package:flutter_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/screens/home/notifications.dart';

class FindPeopleScreen extends StatefulWidget with DrawerStates {
  @override
  _FindPeopleScreenState createState() => _FindPeopleScreenState();
}


class _FindPeopleScreenState extends State<FindPeopleScreen> with AutomaticKeepAliveClientMixin<FindPeopleScreen>  {

  TextEditingController searchTextEditingController = TextEditingController();
  static final usersReference = Firestore.instance.collection('users');
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final  gCurrentUser = auth.currentUser();
  Future<QuerySnapshot> futureSearchResults;  
  bool loading = false;
  // DocumentSnapshot documentSnapshot =  usersReference.document(gCurrentUser.uid).get();
      emptytheTextFormField(){
    searchTextEditingController.clear();
  }
 
  controlSearching(String str){
    Future<QuerySnapshot> allUsers = usersReference.where("name", isGreaterThanOrEqualTo: str).getDocuments();
    setState(() {
      futureSearchResults = allUsers;
    });
  }
    AppBar FindPeopleScreenHeader(){
      return AppBar(
        
        title: TextFormField(
          
           style: TextStyle(fontSize: 18.0, color: Colors.black),
        controller: searchTextEditingController,
        
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: TextStyle(color: Colors.black),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        filled: true,
        prefixIcon: Icon(Icons.person_pin, color: Colors.lightBlue[900], size: 30.0,),
        suffixIcon: IconButton(icon: Icon(Icons.clear, color: Colors.lightBlue[900]), onPressed: emptytheTextFormField,) 
        ),
        onFieldSubmitted: controlSearching,
        ),
  );
  }
  Container displayNoSearchResultScreen(){
    final Orientation orientation = MediaQuery.of(context).orientation;
    return  Container(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Icon(Icons.group, color: Colors.grey, size: 120.0, ),
            Text(
              "Search Users",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 22.0),
            )
          ],
        ),
      ),
    );
  }
  displayUsersFoundScreen(){
    return FutureBuilder(
      
      future: futureSearchResults,
      builder: (context, dataSnapshot)
      {
        if(!dataSnapshot.hasData)
        {
          return CircularProgressIndicator();
        }
        List<UserResult> searchUsersResult = [];
          dataSnapshot.data.documents.forEach((document)
          {
            
            User eachUser = User.fromDocument(document);
            UserResult userResult = UserResult(eachUser);
            searchUsersResult.add(userResult);
            
          });
          return ListView(
            children: searchUsersResult
          );
        },
      );
       }
        bool get wantKeepAlive => true;


  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: FindPeopleScreenHeader(),
      
      body: futureSearchResults == null ? displayNoSearchResultScreen() : displayUsersFoundScreen(),
    );
  }
}

class UserResult extends StatelessWidget {
   final User eachUser;
  UserResult(this.eachUser);
      @override
  Widget build(BuildContext context) {
    return Padding(
      
      padding: EdgeInsets.all(3.0),
      child: Container(
        color: Colors.white54,
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: ()=> 
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchedUser (eachUser : eachUser))),
              child: ListTile(
                leading : CircleAvatar(backgroundColor: Colors.black,),
                title: Text(eachUser.name, style: TextStyle(
                  color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold,
                ),),
              subtitle: Text(eachUser.id,style: TextStyle(
                color: Colors.black, fontSize: 13.0,
              ),),
              ),
            ),
          ],
        ),
      ),
      
    );
  }
}
class SearchedUser extends StatefulWidget with DrawerStates {
     final User eachUser;
  SearchedUser({Key key,@required this.eachUser}) : super(key : key);
  @override
  _SearchedUserState createState() => _SearchedUserState(eachUser);
}

class _SearchedUserState extends State<SearchedUser> with DrawerStates {
Stream friends;
  static final NotificationsScreen local = NotificationsScreen();
  final databaseReference = Firestore.instance;
   static final FirebaseAuth auth = FirebaseAuth.instance;
      final User eachUser;

  _SearchedUserState(this.eachUser);
@override
 String getname(String  testid) {
    
       StreamBuilder(
        stream: Firestore.instance.collection('users').document(testid).snapshots(),
        builder: (context,snapshot) {
           if(!snapshot.hasData) return const Text("Loading...");
           var userDocument = snapshot.data;
          print( userDocument['name']);
         
        }
        );
        
  }
    dynamic data;

  Future<dynamic> getData() async {
        final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    
    final DocumentReference document =   Firestore.instance.collection('users').document(uid);

    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
     setState(() {
       data =snapshot.data;
     });
    });
 }
   dynamic data2;

  Future<dynamic> getData2() async {

    final DocumentReference document =   Firestore.instance.collection('users').document(eachUser.uid);

    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
     setState(() {
       data2 =snapshot.data;
     });
    });
 }
   dynamic data3;

  Future<dynamic> getData3() async {
        final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;

    final DocumentReference document =   Firestore.instance.collection('users').document(uid).collection('friends').document(eachUser.uid);

    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
     setState(() {
       data3 =snapshot.data;
     });
    });
 }
  getfriends() async {
   final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
   return await Firestore.instance.collection('users').document(uid).collection('friends').snapshots();
 } 
 String  pressed = 'false' ;
 @override
  void initState() {

    super.initState();
    getData();
    getData2();
    getData3();
  
      getfriends().then(( results){
  
      setState(() {
        friends = results;
      });
    });
  }

  getColl() async {
final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
final snapShot =  await Firestore.instance.collection('users').document(uid).collection('friends').document(eachUser.uid).get();
   if (snapShot.exists){
    pressed = 'true';
   }
   else{
    pressed = 'false';
   }
  //  getColl();
 }


 
void  createRecord() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    
         databaseReference.collection('users')
  .document(eachUser.uid).collection('friends').
  document(uid).
  setData({
            'status': false,
            'name' : data['name'],
            'id' : data['id'],
            'recieved' : true,
            'sent' : false,
            'friend_id' : uid,
  });
          databaseReference.collection('users')
  .document(uid).collection('friends').
  document(eachUser.uid).
  setData({
            'status': false,
            'name' : data2['name'],
            'id' : data2['id'],
            'recieved' : false,
            'sent' : true,
            'friend_id' : eachUser.uid,
  });

  }
   void updateRecord() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    
         databaseReference.collection('users')
  .document(eachUser.uid).collection('friends').
  document(uid)
 .updateData({
      'status' : true,
    });
          databaseReference.collection('users')
  .document(uid).collection('friends').
  document(eachUser.uid)
 .updateData({
      'status' : true,
    });

  }
  void deleteData() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
  try {
    databaseReference.collection('users')
  .document(eachUser.uid).collection('friends').
  document(uid)
        .delete();
      databaseReference.collection('users')
  .document(uid).collection('friends').
  document(eachUser.uid)
        .delete();     
  } catch (e) {
    print(e.toString());
  }
 build(context);
}

//  Widget  _buttons(BuildContext context){
  _buttons(){
getColl();
// return StreamBuilder(
//   stream: friends,
//   builder: (context,snapshot){  
   print(pressed);
    if(pressed== 'true')
   { 
       if(data3['status'] == false)
       {
         if(data3['recieved'] == true)
         {
         return Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
                RaisedButton(
            color : Colors.grey,
            child: Text('Accept Request', style: TextStyle(color: Colors.white, fontSize: 16.0,), ),
            onPressed: () {
              updateRecord();
              _buttons();
            }
            ),
                 RaisedButton(
            color : Colors.grey,
            child: Text('delete Request', style: TextStyle(color: Colors.white, fontSize: 16.0,), ),
            onPressed: ()=> deleteData()),
             ] );
     
         }
         else{
            return RaisedButton(
            color : Colors.lightBlue[900],
           
            child: Text('cancel request', style: TextStyle(color: Colors.white, fontSize: 16.0,), ),
            onPressed: (){deleteData(); _buttons();});   
       }
     }
     else{
             return Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
                RaisedButton(
            color : Colors.grey,
            child: Text('Remove friend'),
            onPressed: ()=> deleteData()),
                 RaisedButton(
            color : Colors.lightBlue[900],
            child: Text('Send Message', style: TextStyle(color: Colors.white, fontSize: 16.0,), ),
            onPressed: ()=> null),
             ] );
     }
   }
   else if (pressed == 'false' || pressed == 'pressed')
   {
   return RaisedButton(
            color : Colors.lightBlue[900],
            child: Text('Send request',style: TextStyle(color: Colors.white, fontSize: 16.0,), 
            ),

            onPressed: () {createRecord(); _buttons(); FriendReqNotification();});
   }
  // });c
 }
  @override
  Widget build(BuildContext context) {

  return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('users').document(eachUser.uid).snapshots(),
        builder: (context,snapshot) {
           if(!snapshot.hasData) return const Text("Loading...");
           var userDocument = snapshot.data;
           return Column(
        children: <Widget>[
         
          Padding(
           padding: EdgeInsets.only(top: 50),
            child: Text(userDocument['name'],
                style: TextStyle(color: Colors.grey[800],fontSize: 24, fontFamily: 'OpenSans',fontWeight: FontWeight.bold),
              ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child:
            Text(userDocument['id'],
                style: TextStyle(color: Colors.grey[1200],fontSize: 20, fontFamily: 'OpenSans'),
              ),
          ),
          Text(
            'Registered Courses',
            textAlign: TextAlign.center,
             style: TextStyle(color: Colors.grey[900],fontSize: 24, fontFamily: 'OpenSans',fontWeight: FontWeight.bold),
          ),
         Padding(
            
           padding: EdgeInsets.only(top: 20),
            child:
            Text(userDocument['course1'],
                style: TextStyle(fontSize: 14),
              ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(8),
            child:
            Text(userDocument['course2'],
                style: TextStyle(fontSize: 14),
              ),
          ),
          Padding(
             padding: EdgeInsets.only(bottom: 20),
            child:
            Text(userDocument['course3'],
                style: TextStyle(fontSize: 14),
              ),
          ),
          Row(
            
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                 margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                 child: _buttons(),
              )
            ],
          ),    
        ],
        );
        }
        ),
     
    );
  }
}
