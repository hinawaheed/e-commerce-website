import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/friends.dart';
import 'package:flutter_app/models/message.dart';
import 'package:flutter_app/models/user.dart';

class ChatMethods {
  static final Firestore _firestore = Firestore.instance;

  final CollectionReference _messageCollection =
      _firestore.collection('messages');

  final CollectionReference _userCollection =
      _firestore.collection('users');

  Future<void> addMessageToDb(
      Message message, User sender, User receiver) async {
    var map = message.toMap();

    await _messageCollection
        .document(message.senderId)
        .collection(message.receiverId)
        .add(map);

    addToFriends(senderId: message.senderId, receiverId: message.receiverId);

    return await _messageCollection
        .document(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }

  DocumentReference getFriendsDocument({String of, String forFriend}) =>
      _userCollection
          .document(of)
          .collection('friends')
          .document(forFriend);

  addToFriends({String senderId, String receiverId}) async {
    Timestamp currentTime = Timestamp.now();

    await addToSenderFriends(senderId, receiverId, currentTime);
    await addToReceiverFriends(senderId, receiverId, currentTime);
  }

  Future<void> addToSenderFriends(
    String senderId,
    String receiverId,
    currentTime,
  ) async {
    DocumentSnapshot senderSnapshot =
        await getFriendsDocument(of: senderId, forFriend: receiverId).get();

    if (!senderSnapshot.exists) {
      //does not exists
     Friend receiverFriend = Friend(
        uid: receiverId,
      );

      var receiverMap = receiverFriend.toMap(receiverFriend);

      await getFriendsDocument(of: senderId, forFriend: receiverId)
          .setData(receiverMap);
    }
  }

  Future<void> addToReceiverFriends(
    String senderId,
    String receiverId,
    currentTime,
  ) async {
    DocumentSnapshot receiverSnapshot =
        await getFriendsDocument(of: receiverId, forFriend: senderId).get();

    if (!receiverSnapshot.exists) {
      //does not exists
      Friend senderFriend = Friend(
        uid: senderId,
      );

      var senderMap = senderFriend.toMap(senderFriend);

      await getFriendsDocument(of: receiverId, forFriend: senderId)
          .setData(senderMap);
    }
  }

  void setImageMsg(String url, String receiverId, String senderId) async {
    Message message;

    message = Message.imageMessage(
        message: "IMAGE",
        receiverId: receiverId,
        senderId: senderId,
        photoUrl: url,
        timestamp: Timestamp.now(),
        type: 'image');

    // create imagemap
    var map = message.toImageMap();

    // var map = Map<String, dynamic>();
    await _messageCollection
        .document(message.senderId)
        .collection(message.receiverId)
        .add(map);

    _messageCollection
        .document(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }

  Stream<QuerySnapshot> fetchFriends({String userId}) { 
    return Firestore.instance.collection('users')
      .document(userId)
      .collection('friends')
      .snapshots();
  }

  Stream<QuerySnapshot> fetchLastMessageBetween(
    String senderId,
   String receiverId,
  ) {
    print('this is in fetch msg');
    print(senderId);
    print(receiverId);
 return   _firestore.collection('messages')
          .document(receiverId)
          .collection(senderId)
          .orderBy("timestamp")
          .snapshots();
 
}}