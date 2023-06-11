import 'package:flutter/material.dart';
import '../shared/widgets/header.dart';
import './widgets/email_field.dart';
import './widgets/reset_button.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: const Padding(
        padding: EdgeInsets.all(40.0),
        child: Column(
          children: [
            Header(
              title: "Password?",
              info: "Fear not. Recovery Email Incoming",
            ),
            SizedBox(height: 30.0),
            EmailField(),
            SizedBox(height: 15.0),
            ResetButton(),
          ],
        ),
      ),
    );
  }
}
