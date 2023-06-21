import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../shared/widgets/header.dart';
import './widgets/text_section.dart';
import './widgets/email_sent_text.dart';
import './widgets/resend_button.dart';
import './widgets/check_spam_text.dart';
import './widgets/why_verify_tappable_text.dart';
import './widgets/switch_account_link.dart';

class EmailVerificationScreen extends ConsumerWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(forceMaterialTransparency: true),
      body: const Padding(
        padding: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 40.0),
        child: Column(
          children: [
            Header(
              title: "Verify Email",
              info: "Pssst! Your inbox holds hidden surprises!",
            ),
            SizedBox(height: 35.0),
            TextSection(),
            EmailSentText(),
            ResendButton(),
            SizedBox(height: 10.0),
            CheckSpamText(),
            SizedBox(height: 10.0),
            WhyVerifyTappableText(),
            SwitchAccountLink(),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
