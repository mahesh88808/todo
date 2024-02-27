import 'package:flutter/material.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/utils/show_dialog.dart';
import '../repo/todo_queries.dart';

class AddTodoProvider extends ChangeNotifier {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();

  TextEditingController get titleController => _titleController;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get userIdController => _userIdController;


  void addTodo(BuildContext context) async {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    final addTaskMail = _userIdController.text.trim();

    if (title.isNotEmpty && description.isNotEmpty) {
      TodoModel model = TodoModel(
          id: '',
          senderMail: '',
          title: title,
          description: description,
          status: false,
          receiverMail: addTaskMail);
      await TodoQueries().addTodo(context,model);
      Navigator.pop(context);
    } else {
      showDialog(
          context: context,
          builder: (context) => ShowDialog(
                  title: 'Error',
                  content: 'Please fill in all fields.',
                  buttonWidgets: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ]));
    }
  }
}
