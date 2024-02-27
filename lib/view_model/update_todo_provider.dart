import 'package:flutter/cupertino.dart';
import '../repo/todo_queries.dart';

class UpdateTodoProvider extends ChangeNotifier {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedValue = 'Pending';
  get titleController => _titleController;
  get descriptionController => _descriptionController;
  get selectedValue => _selectedValue;
  UpdateTodoProvider(String value) {
    _selectedValue = value;
  }

  Future<void> updateTodo(BuildContext context, String id) async {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    await TodoQueries().updateTodo(
        context, title, description, _selectedValue == 'Completed' ? 1 : 0, id);

    Navigator.pop(context);
  }

  void changeDropdownValue(String? newValue) {
    _selectedValue = newValue!;
    notifyListeners();
  }
}
