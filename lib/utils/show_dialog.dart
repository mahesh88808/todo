import 'package:flutter/material.dart';

class ShowDialog extends StatelessWidget {
  String title;
  String content;
  final List<Widget> buttonWidgets;
  ShowDialog(
      {Key? key,
      this.title = '',
      this.content = '',
      required this.buttonWidgets})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(title), content: Text(content), actions: buttonWidgets);
  }
}
