import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../shared/widgets/header.dart';
import './widgets/error_message.dart';
import './widgets/email_field.dart';
import './widgets/reset_button.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(forceMaterialTransparency: true),
      body: const Padding(
        padding: EdgeInsets.fromLTRB(40.0, 50.0, 40.0, 40.0),
        child: Column(
          children: [
            Header(
              title: "Password?",
              info: "Missing password? Panic mode!",
            ),
            ErrorMessage(),
            EmailField(),
            SizedBox(height: 20.0),
            ResetButton(),
          ],
        ),
      ),
    );
  }
}
