import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../routes/route_pages.dart';
import '../../services/auth/user_auth.dart';
import '../../services/auth/email_password_auth.dart';

//* Check every {verifyCheckDuration} if user is verified
//* After email resend ability disabled for {resendTimeout} seconds countdown

const Duration verifyCheckDuration = Duration(seconds: 3);
const int resendTimeout = 30;

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({Key? key}) : super(key: key);

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  Timer? verifyCheckTimer;
  int currentResendTimeout = 0;

  bool get canResend => currentResendTimeout <= 0;

  @override
  void initState() {
    // Send email, and start timer to refresh every {verifyCheckDuration} to check for change
    try {
      sendEmail();
      verifyCheckTimer = Timer.periodic(verifyCheckDuration, (timer) async {
        await UserAuth.reload();
        if (UserAuth.verified) {
          Get.offAllNamed(RoutePage.home);
        }
      });
    } catch (e) {
      Get.offAllNamed(RoutePage.error);
    }

    super.initState();
  }

  @override
  void dispose() {
    if (verifyCheckTimer != null) verifyCheckTimer!.cancel();
    currentResendTimeout = 0;
    super.dispose();
  }

  void sendEmail() async {
    if (!canResend) return;
    currentResendTimeout = resendTimeout;
    setState(() {});
    EmailPasswordAuth.sendEmailVerification();
    while (currentResendTimeout > 0 && mounted) {
      await Future.delayed(const Duration(seconds: 1));
      // Empty set state to update countdown (currentResendTimeout--)

      // Ensure that state object still in tree before setState
      if (mounted) setState(() => currentResendTimeout--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //! LOGO
            Image.asset(
              "assets/logo_outline.png",
              fit: BoxFit.contain,
              width: 150.0,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            //! LABEL
            Text(
              "Verify Email",
              style: GoogleFonts.pacifico(fontSize: 42.0),
            ),
            //! INFO TEXT
            const SizedBox(height: 20),
            const Text("A verification email has been sent to you"),
            const SizedBox(height: 20),
            const Text("Didn't get any email?"),
            const SizedBox(height: 10),
            //! RESEND EMAIL BUTTON
            ElevatedButton.icon(
              onPressed: canResend ? () => sendEmail() : null,
              icon: const Icon(Icons.email),
              label: Text(
                  "Resend Email${canResend ? '' : ' In: $currentResendTimeout'}"),
            ),
            //! GO BACK BUTTON
            OutlinedButton(
              onPressed: () {
                UserAuth.signOut();
                Get.toNamed(RoutePage.login);
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                    width: 2, color: Theme.of(context).colorScheme.background),
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
              child: const Text("Go Back"),
            ),
          ],
        ),
      ),
    );
  }
}
