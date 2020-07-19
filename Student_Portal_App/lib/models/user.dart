import 'package:cloud_firestore/cloud_firestore.dart';
class User {

   String uid;
   String name;
   String id;
   String status;
  int state;


  User({ 
    this.uid,
    this.name,
    this.id, 
     this.status,
    this.state,
    });
    Map toMap(User user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.uid;
    data['name'] = user.name;
    data['id'] = user.name;
    data["status"] = user.status;
    data["state"] = user.state;
       return data;
  }
  // Named constructor
  User.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.name = mapData['name'];
    this.id = mapData['id'];
    this.status = mapData['status'];
    this.state = mapData['state'];
  }

factory User.fromDocument(DocumentSnapshot doc){
  return User (
    uid : doc.documentID,
    id : doc['id'],
    name : doc['name'],
    state: doc['state'],
    status: doc['sttaus'],
  );
}
}

