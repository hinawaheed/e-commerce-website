import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/drawer_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/screens/home/sendmessgae.dart';
import 'package:flutter_app/shared/loading.dart';
class FriendListScreen extends StatefulWidget with DrawerStates {
  @override
  _FriendListScreenState createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  
   static final FirebaseAuth auth = FirebaseAuth.instance;
   Stream friends;
   QuerySnapshot results;
    String  useruid;
   dynamic data;
     
  
  getdata() async {
   final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    useruid = uid;
   return  Firestore.instance.collection('users').document(uid).collection('friends').snapshots();
 } 
  void initState(){

    getdata().then(( results){
  
      setState(() {
        friends = results;
      });
    });
  
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _friendsList(context),
      appBar: AppBar(
        
      ),
      );
        
  }
 
  Widget _friendsList(BuildContext context){
   Padding(padding: const EdgeInsets.all(10.0));
   AppBar(
     title: Text('Friends '),
   );
    if(friends != null){     
    
     return  StreamBuilder(
       stream: friends , 
       builder:(context,snapshot){
        if (snapshot.data.documents.length == null){
     return Loading();
     }    
      return ListView.builder(       
        itemCount: snapshot.data.documents.length,
        padding: EdgeInsets.all(5.0),
        itemBuilder: (context, i){
           return Card(
             
          elevation: 20,
          child: InkWell(       
           child : Text(snapshot.data.documents[i].data['status'] == false ? 
           snapshot.data.documents[i].data['recieved'] == true ? 
           snapshot.data.documents[i].data['name'] + ' has sent you request' 
           : 'you have sent request to ' + snapshot.data.documents[i].data['name']
           : snapshot.data.documents[i].data['name']),
            onTap: ()=> (() {
              if(snapshot.data.documents[i].data['status'] ==false && snapshot.data.documents[i].data['recieved'] == true) {
           Navigator.push(
             
              context,
              MaterialPageRoute(builder: (context) => getprofile(context,i,useruid)));
              }
              else if (snapshot.data.documents[i].data['status'] == false && snapshot.data.documents[i].data['recieved']== false)
              {
                 Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => getprofile2(context,i,useruid)));
              }
              else if(snapshot.data.documents[i].data['status'] == true && (snapshot.data.documents[i].data['recieved']== false || snapshot.data.documents[i].data['recieved']== true )) {
                 Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => showprofile(context, snapshot.data.documents[i].documentID) ));
              }
              }()) 
              
    ),
);
        });
         } );
    }
    else {
       CircularNotchedRectangle();
    }

  }
   final databaseReference = Firestore.instance;
  deleterequest( String uid, String request){
      try {
    databaseReference.collection('users')
  .document(uid).collection('friends').
  document(request)
        .delete();
     databaseReference.collection('users')
  .document(request).collection('friends').
  document(uid)
        .delete();
  } catch (e) {
    print(e.toString());
  }
  }
  acceptrequest(String uid, String request){
        try {
    databaseReference.collection('users')
  .document(uid).collection('friends').
  document(request)
    .updateData({
      'status' : true,
    });
    databaseReference.collection('users')
  .document(request).collection('friends').
  document(uid)
    .updateData({
      'status' : true,
    });
  } catch (e) {
    print(e.toString());
  }
  
  }
  Widget getprofile(BuildContext context, int index, String uid)
  {
    print('getprofile');
    return Scaffold(
      
    appBar: AppBar(
      title: Text('Profile'),
    ),
    body: StreamBuilder(
      stream: Firestore.instance.collection('users').document(uid).collection('friends').snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData) return Text('loading data..Please wait');       
         return Column(
          children: <Widget>[
            
      

            Padding(
            padding: EdgeInsets.only(top: 50),
              child: Text(snapshot.data.documents[index]['name'],style: TextStyle(color: Colors.grey[800],fontSize: 24, fontFamily: 'OpenSans',fontWeight: FontWeight.bold),),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(snapshot.data.documents[index]['id'],style: TextStyle(color: Colors.grey[1200],fontSize: 20, fontFamily: 'OpenSans'),),
            ),
              Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
            color : Colors.lightBlue[900],
            child: Text('Accept Request',
           style: TextStyle(color: Colors.white, fontSize: 14.0,), 
           ),
            onPressed: () {
              acceptrequest(uid, snapshot.data.documents[index].documentID);
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FriendListScreen()));
            }
            ),
            RaisedButton(
            color : Colors.lightBlue[900],
                child: Text(
                 'Reject request ',
                 style: TextStyle(color: Colors.white, fontSize: 14.0,), 
                ),
            onPressed: () {
              deleterequest(uid, snapshot.data.documents[index].documentID);
             Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FriendListScreen()));
            },
            )
            ],
          ), 
          ],

        );
      }
      ),
    );
  }
   Widget getprofile2(BuildContext context, int index, String uid)
  {
    print('getprofile2');
    return Scaffold(
      
    appBar: AppBar(
      title: Text('Profile'),
    ),
    body: StreamBuilder(
      stream: Firestore.instance.collection('users').document(uid).collection('friends').snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData) return Text('loading data..Please wait');       
         return Column(
          children: <Widget>[
            Padding(
            padding: EdgeInsets.only(top: 50),
              child: Text(snapshot.data.documents[index]['name'],style: TextStyle(color: Colors.grey[800],fontSize: 24, fontFamily: 'OpenSans',fontWeight: FontWeight.bold),),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(snapshot.data.documents[index]['id'],style: TextStyle(color: Colors.grey[1200],fontSize: 20, fontFamily: 'OpenSans'),),
            ),
              Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              
            RaisedButton(
            color : Colors.lightBlue[900],
                child: Text(
                 'cancel request ',
                 style: TextStyle(color: Colors.white, fontSize: 14.0,), 
                ),
            onPressed: () {
              deleterequest(uid, snapshot.data.documents[index].documentID);
             Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FriendListScreen()));
            },
            )
            ],
          ), 
          ],

        );
      }
      ),
    );
  }
  Widget showprofile(BuildContext context, String uid){
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('users').document(uid).snapshots(),
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
            RaisedButton(
            color : Colors.lightBlue[900],
                child: Text(
                 'Send Message ',
                 style: TextStyle(color: Colors.white, fontSize: 14.0,), 
                ),
            onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SendMessage(receiveruid : uid, senderuid : useruid)));
            }
            ),
           RaisedButton(
            color : Colors.lightBlue[900],
                child: Text(
                 'Remove Friend ',
                 style: TextStyle(color: Colors.white, fontSize: 14.0,), 
                ),
            onPressed:(){ deleterequest(useruid, uid);
             Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FriendListScreen()));
            }
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

