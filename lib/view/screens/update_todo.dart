import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/utils/responsive.dart';
import '../../model/todo_model.dart';
import '../../view_model/update_todo_provider.dart';
import '../widgets/text_field.dart';

class EditTodoScreen extends StatelessWidget {
  final TodoModel todo;

  const EditTodoScreen({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit TODO'),
        ),
        body: ChangeNotifierProvider(
          create: (context) =>
              UpdateTodoProvider(todo.status ? 'Completed' : 'Pending'),
          child:
              Consumer<UpdateTodoProvider>(builder: (context, provider, child) {
            provider.titleController.text = todo.title;
            provider.descriptionController.text = todo.description;
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: context.responsiveHeight(16),
                  horizontal: context.responsiveWidth(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MyTextFields(
                      controller: provider.titleController, labelText: 'Title'),
                  SizedBox(height: context.responsiveHeight(16)),
                  MyTextFields(
                      controller: provider.descriptionController,
                      labelText: 'Description'),
                  SizedBox(height: context.responsiveHeight(16)),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8,horizontal: context.responsiveWidth(8)),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey), // Border color
                      borderRadius: BorderRadius.circular(10.0), // Border radius
                    ),
                    child: DropdownButton<String>(
                      value: provider.selectedValue,
                      onChanged: (String? newValue) {
                        provider.changeDropdownValue(newValue);
                      },
                      underline: Container(),
                      items: <String>['Pending', 'Completed']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: context.responsiveHeight(20)),
                  ElevatedButton(
                    onPressed: () {
                      provider.updateTodo(context, todo.id);
                    },
                    child: const Text('Update'),
                  ),
                ],
              ),
            );
          }),
        ));
  }
}
