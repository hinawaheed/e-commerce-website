
import 'package:flutter_app/models/message.dart';
import 'package:flutter_app/resources/firebase_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRepository {
  FirebaseMethods _firebaseMethods = FirebaseMethods();

  Future<FirebaseUser> getCurrentUser() => _firebaseMethods.getCurrentUser();

  Future<void> addMessageToDb(Message message, String sender, String receiver) =>
      _firebaseMethods.addMessageToDb(message, sender, receiver);
}