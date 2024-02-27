import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/view/screens/update_todo.dart';
import '../../model/todo_model.dart';
import '../../repo/auth.dart';

class ReceivedTask extends StatelessWidget {
  const ReceivedTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: AuthService()
            .firestore
            .collection('todos')
            .where('receiver_mail',
                isEqualTo: AuthService().auth.currentUser!.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('No Task Received',
                    style: TextStyle(color: Colors.black)),
              );
            } else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final todo = TodoModel.fromJson(snapshot.data!.docs[index]);
                  return Column(
                    children: [
                      ListTile(
                        title: Text(todo.title),
                        subtitle: Text(todo.description),
                        trailing: Text(todo.status ? 'Completed' : 'Pending'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditTodoScreen(todo: todo)));
                        },
                      ),
                      const Divider()
                    ],
                  );
                },
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
