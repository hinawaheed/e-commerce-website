import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/models/friends.dart';
import 'package:flutter_app/resources/chat_methods.dart';
import 'package:flutter_app/resources/firebase_repo.dart';
import 'package:flutter_app/screens/home/drawer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/screens/home/widgets/friend_view.dart';
import 'package:flutter_app/screens/home/widgets/quiet_box.dart';
import 'package:flutter_app/utilities/universal_var.dart';

class ChatScreen extends StatelessWidget with DrawerStates {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVariables.blackColor,
      body: ChatListContainer(),
     
    );
  }
}
class ChatListContainer extends StatefulWidget {
  @override
  _ChatListContainerState createState() => _ChatListContainerState();
}

class _ChatListContainerState extends State<ChatListContainer> {
final FirebaseRepository _repository = FirebaseRepository();
 static final FirebaseAuth auth = FirebaseAuth.instance;
String currentUserid= 'hello';
final ChatMethods _chatMethods = ChatMethods();

 @override
  void initState(){
    super.initState();
    _repository.getCurrentUser().then((user){
      setState(() {
        currentUserid = user.uid;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: _chatMethods.fetchFriends(
          userId: currentUserid,
        ),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            var docList = snapshot.data.documents;
            if(docList.isEmpty) 
            {
              return QuietBox();
            }
            return ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: docList.length,
            itemBuilder: (context, index) {
              // if(docList[index].data['status']== true) {
              Friend friend = Friend.fromMap(docList[index].data);
              return FriendView(friend);
              // }
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(),

        );
        }),
    );
  }
}
