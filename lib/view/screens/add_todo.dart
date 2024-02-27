import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/utils/responsive.dart';
import '../../view_model/add_todo_provider.dart';
import '../widgets/text_field.dart';

class AddTodoScreen extends StatelessWidget {
  const AddTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add TODO'),
      ),
      body: ChangeNotifierProvider(
          create: (context) => AddTodoProvider(),
          child: Consumer<AddTodoProvider>(builder: (context, provider, child) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.responsiveWidth(16.0),
                  vertical: context.responsiveHeight(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MyTextFields(
                    controller: provider.titleController,
                    labelText: 'Title',
                  ),
                  SizedBox(height: context.responsiveHeight(16)),
                  MyTextFields(
                    controller: provider.descriptionController,
                    labelText: 'Description',
                  ),
                  SizedBox(height: context.responsiveHeight(16)),
                  MyTextFields(
                    controller: provider.userIdController,
                    labelText: 'Assign to User Mail id',
                  ),
                  SizedBox(height: context.responsiveHeight(20)),
                  ElevatedButton(
                    onPressed: () {
                      provider.addTodo(context);
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
            );
          })),
    );
  }
}
