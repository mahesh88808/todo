import 'package:flutter/material.dart';
import '../repo/auth.dart';
import '../utils/show_dialog.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  TextEditingController get mailController => _mailController;
  TextEditingController get passwordController => _passwordController;

  Future<void> login(BuildContext context) async {
    final mail = _mailController.text.trim();
    final password = _passwordController.text.trim();
    if (mail.isNotEmpty && password.isNotEmpty) {
      AuthService().login(context, mail, password);
    } else {
      showDialog(
          context: context,
          builder: (context) => ShowDialog(
                  title: 'Error',
                  content: 'User not exist or Credentials not correct',
                  buttonWidgets: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ]));
    }
  }
}
