import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/utils/snack_bar.dart';

import 'auth.dart';

class TodoQueries {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addTodo(BuildContext context, TodoModel model) async {
    try {
      Map<String, dynamic> data = {
        'sender_mail': _auth.currentUser!.email,
        'receiver_mail': model.receiverMail,
        'title': model.title,
        'description': model.description,
        'status': model.status
      };
      await _firestore.collection('todos').add(data);
      CommonSnackbar.showSnackbar(context, "Added to Created Task");
    } catch (e) {
      CommonSnackbar.showSnackbar(context, e.toString());
    }
  }

  Future<void> updateTodo(BuildContext context, String title,
      String description, int status, String id) async {
    try {
      await AuthService().firestore.collection('todos').doc(id).update(
          {'title': title, 'description': description, 'status': status});
      CommonSnackbar.showSnackbar(context, "Updated");
    } catch (e) {
      CommonSnackbar.showSnackbar(context, e.toString());
    }
  }
}
