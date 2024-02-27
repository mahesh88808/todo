import 'package:flutter/material.dart';
import 'package:todo/repo/auth.dart';
import 'package:todo/view/screens/recieved_task.dart';
import '../../utils/show_dialog.dart';
import 'add_todo.dart';
import 'created_tasks.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO List'),
        actions: [
          IconButton(
              onPressed: () {
                signOut();
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
                physics: const NeverScrollableScrollPhysics(),
                indicatorColor: Colors.purpleAccent,
                onTap: (i) => FocusManager.instance.primaryFocus?.unfocus(),
                tabs: const [
                  Tab(
                    text: 'Created Tasks',
                  ),
                  Tab(
                    text: 'Received Tasks',
                  ),
                ]),
            const Expanded(
                child: TabBarView(children: [CreatedTask(), ReceivedTask()]))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddScreen();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigateToAddScreen() async {
    Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AddTodoScreen()))
        .then((value) {});
  }

  void signOut() {
    showDialog(
        context: context,
        builder: (context) => ShowDialog(
                title: 'Logout',
                content: 'Do you want to Logout ?',
                buttonWidgets: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () => AuthService().signOut(context),
                    child: const Text('Yes'),
                  ),
                ]));
  }
}
