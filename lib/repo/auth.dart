import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:todo/view/screens/login.dart';
import '../utils/snack_bar.dart';
import '../view/screens/todo_list.dart';

class AuthService {
  login(BuildContext context, String mail, String password) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    try {
      User? user = (await _auth.signInWithEmailAndPassword(
              email: mail, password: password))
          .user;
      var token = await getNotificationToken();
      await _firestore
          .collection('users')
          .doc(_auth.currentUser?.uid)
          .set({'token': token}, SetOptions(merge: true));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => TodoListScreen()));
    } catch (e) {
      if(e.toString()=='[firebase_auth/invalid-credential] The supplied auth credential is incorrect, malformed or has expired.'){
        CommonSnackbar.showSnackbar(context, 'Invalid Credentials');
      }else{
        register(context, mail, password);
      }
    }
  }

  Future<Object?> register(
      BuildContext context, String mail, String password) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    try {
      User? user = (await _auth.createUserWithEmailAndPassword(
              email: mail, password: password))
          .user;
      if (user != null) {
        var token = await getNotificationToken();
        await _firestore.collection('users').doc(_auth.currentUser?.uid).set({
          "email": mail,
          "password": password,
          "uid": _auth.currentUser!.uid
        });
        await _firestore
            .collection('users')
            .doc(_auth.currentUser?.uid)
            .set({'token': token}, SetOptions(merge: true));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => TodoListScreen()));
      } else {
        print("error");
      }
    } catch (e) {
      CommonSnackbar.showSnackbar(context, e.toString());
      print(e);
    }
  }

  void signOut(BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }

  Future<String?> getNotificationToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    return token;
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
}
