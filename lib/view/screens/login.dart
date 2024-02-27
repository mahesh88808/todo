import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/utils/responsive.dart';
import 'package:todo/view/widgets/text_field.dart';

import '../../view_model/login_provider.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
          create: (context) => LoginProvider(),
          child: Consumer<LoginProvider>(builder: (context, provider, child) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Todo Login / SignUp',
                      style: TextStyle(fontSize: context.responsiveWidth(30))),
                  SizedBox(height: context.responsiveHeight(16)),
                  MyTextFields(
                    controller: provider.mailController,
                    labelText: 'Email',
                  ),
                  SizedBox(height: context.responsiveHeight(8)),
                  MyTextFields(
                    controller: provider.passwordController,
                    labelText: 'Password',
                  ),
                  SizedBox(height: context.responsiveHeight(8)),
                  SizedBox(
                    width: context.width,
                    child: ElevatedButton(
                      onPressed: () {
                        provider.login(context);
                      },
                      child: const Text('Login'),
                    ),
                  ),
                ],
              ),
            );
          })),
    );
  }
}
