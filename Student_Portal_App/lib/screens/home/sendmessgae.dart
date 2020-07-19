import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/models/message.dart';
import 'package:flutter_app/utilities/universal_var.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/resources/firebase_repo.dart';

class SendMessage extends StatefulWidget {
  @override
   final String receiveruid;
   final String senderuid;
  SendMessage({Key key,@required this.receiveruid, @required this.senderuid}) : super(key : key);
  _SendMessageState createState() => _SendMessageState(receiveruid,senderuid);
 
}

class _SendMessageState extends State<SendMessage> {
String receiveruid;
String senderuid;

TextEditingController textFieldController = TextEditingController();
 _SendMessageState(this.receiveruid, this.senderuid);
  dynamic data;
  bool iswriting = false;
    static final FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseRepository _repository = FirebaseRepository();
  
  Future<dynamic> getData() async {
    print('this is recievers uid');
    print(receiveruid);
        final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    
    final DocumentReference document =   Firestore.instance.collection('users').document(receiveruid);

    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
     setState(() {
       data =snapshot.data;
     });
    });
 }
  void initState() {

    super.initState();
    getData();
   
  }
  @override
  Widget build(BuildContext context) { 
   getData();
    return Scaffold(
      appBar: AppBar(
        title: Text(data['name']),
      ),
        body: Column(
        children: <Widget>[
          Flexible(
            child: messageList(),
          
          ),
          chatcontrols(), 
        ],
      ),
    );
  }
 Widget messageList() {
    return StreamBuilder(
      stream: Firestore.instance
          .collection("messages")
          .document(senderuid)
          .collection(receiveruid)
          .orderBy("timestamp", descending: false)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) {
            return chatMessageItem(snapshot.data.documents[index]);
          },
        );
      },
    );
  }
 Widget chatMessageItem(DocumentSnapshot snapshot) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Container(
        alignment: snapshot['senderId'] == senderuid
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: snapshot['senderId'] == senderuid
            ? senderLayout(snapshot)
            : receiverLayout(snapshot),
      ),
    );
  }
  Widget senderLayout(DocumentSnapshot snapshot) {
    Radius messageRadius = Radius.circular(10);
    return Container(
      margin: EdgeInsets.only(top: 12),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
      decoration: BoxDecoration(
        color : Colors.lightBlue[900],
        borderRadius: BorderRadius.only(
          topLeft: messageRadius,
          topRight: messageRadius,
          bottomLeft: messageRadius,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: getMessage(snapshot),
      ),
    );
  }
  getMessage(DocumentSnapshot snapshot) {
    return Text(
      snapshot['message'],
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
      ),
    );
  }
  Widget receiverLayout(DocumentSnapshot snapshot) {
    Radius messageRadius = Radius.circular(10);

    return Container(
      margin: EdgeInsets.only(top: 12),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
      decoration: BoxDecoration(
       color : Colors.lightBlue[900],
        borderRadius: BorderRadius.only(
          bottomRight: messageRadius,
          topRight: messageRadius,
          bottomLeft: messageRadius,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: getMessage(snapshot)
      ),
    );
  }
 Widget chatcontrols(){
   setWritingto(bool val){
     setState(() {
       iswriting = val;
     });
   }
  sendaMessage(){
    var text = textFieldController.text;
    Message _message = Message(
      receiverId: receiveruid,
      senderId: senderuid,
      message: text,
      timestamp: Timestamp.now(),
      type: 'text',
    );
    setState(() {
      iswriting = false;
    });
    textFieldController.text = '';
    _repository.addMessageToDb(_message, senderuid, receiveruid);

  }

    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              gradient: UniversalVariables.fabGradient, 
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.add),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(child: TextField(
            controller: textFieldController,
            style: TextStyle(
              color: Colors.white,
            ),
            onChanged: (val){
              (val.length > 0 && val.trim() != '') ? setWritingto(true) : setWritingto(false);
            },
           decoration: InputDecoration(
                hintText: "Type a message",
                hintStyle: TextStyle(
                  color: UniversalVariables.greyColor,
                ),
                border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(50.0),
                    ),
                    borderSide: BorderSide.none),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                filled: true,
                fillColor: UniversalVariables.separatorColor,
                suffixIcon: GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.face),
            ),
          ),
          ),
          ),
          iswriting
              ? Container(
                  margin: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      gradient: UniversalVariables.fabGradient,
                      shape: BoxShape.circle),
                  child: IconButton(
                    icon: Icon(
                      Icons.send,
                      size: 15,
                    ),
                    onPressed: () => sendaMessage(),
                  ))
              : Container()
        ],
      ),
    );
  }

}
