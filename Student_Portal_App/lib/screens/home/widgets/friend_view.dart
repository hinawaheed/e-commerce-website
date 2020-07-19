import 'package:flutter/material.dart';
import 'package:flutter_app/resources/firebase_repo.dart';
import 'package:flutter_app/models/friends.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/resources/auth_methods.dart';
import 'package:flutter_app/resources/chat_methods.dart';
import 'package:flutter_app/screens/home/widgets/online_dot_indicator.dart';
import 'package:flutter_app/screens/home/widgets/custom_tile.dart';
import '../sendmessgae.dart';
import 'last_message_container.dart';

class FriendView extends StatelessWidget {
  final Friend friend;
  final AuthMethods _authMethods = AuthMethods();

  FriendView(this.friend);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: _authMethods.getUserDetailsById(friend.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData )
         {
         
          User user = snapshot.data;
          return ViewLayout(
            friend: user,
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class ViewLayout extends StatefulWidget {
  @override
    final User friend;
    ViewLayout({Key key,@required this.friend}) : super(key : key);
 
  _ViewLayoutState createState() => _ViewLayoutState(friend);
}

class _ViewLayoutState extends State<ViewLayout> {

  final User friend;
  String currentUserid;
_ViewLayoutState(@required this.friend);
  final FirebaseRepository _repository = FirebaseRepository();
 
  void initState(){
    super.initState();
    _repository.getCurrentUser().then((user){
      setState(() {
        currentUserid = user.uid;
      });
    });
  }

 final ChatMethods _chatMethods = ChatMethods();
  @override
  Widget build(BuildContext context) {
    return CustomTile(
      mini: false,
      onTap:
      () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SendMessage(receiveruid: friend.uid,senderuid: currentUserid,),
          )),
      title: Text(
        (friend != null ? friend.name : null) != null ? friend.name : "..",
        style:
            TextStyle(color: Colors.white, fontFamily: "Arial", fontSize: 19),
      ),
      
      subtitle: LastMessageContainer(
        stream: _chatMethods.fetchLastMessageBetween(
           currentUserid,
           friend.uid,
        ),
      ),
      leading: Container(
        constraints: BoxConstraints(maxHeight: 60, maxWidth: 60),
        child: Stack(
          children: <Widget>[
             CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage("https://www.worldatlas.com/r/w1200-h701-c1200x701/upload/59/fd/9c/shutterstock-757438030.jpg"),
                  ),
            OnlineDotIndicator(
              uid: friend.uid,
            ),
          ],
        ),
      ),
    );
  }
}