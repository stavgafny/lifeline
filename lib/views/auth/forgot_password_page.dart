import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/form_controller.dart';
import '../../services/email_password_auth.dart';
import '../../routes/route_pages.dart';
import '../../widgets/entry.dart';
import '../../widgets/loading_button.dart';

const generalPadding = EdgeInsets.symmetric(horizontal: 50.0);

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.delete<FormController>();

    final emailController = TextEditingController();

    final formController = Get.put(FormController([emailController]));

    void showSuccessDialog() {
      Get.defaultDialog(
        title: "Success",
        middleText: "Password reset link sent!\n\n"
            "Set up a new password...\n"
            "You know the drill",
        confirm: ElevatedButton(
          onPressed: () {
            Get.back();
            Get.toNamed(RoutePage.login);
          },
          child: const Text("Go to Login"),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        titleStyle: const TextStyle(color: Colors.white),
        middleTextStyle: const TextStyle(color: Colors.white),
        radius: 50,
      );
    }

    void passwordReset(String email) async {
      final requirements = EmailPasswordAuth.validate(email: email);
      if (requirements.isNotEmpty) {
        formController.setErrorMessage(requirements.join("\n"));
      } else {
        formController.setProcessing(true);
        String? response = await EmailPasswordAuth.passwordReset(email: email);
        if (response == null) {
          showSuccessDialog();
        } else {
          formController.setErrorMessage(response);
        }
        formController.setProcessing(false);
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            reverse: true,
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
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
                  "Recover Password",
                  style: GoogleFonts.pacifico(fontSize: 42.0),
                ),
                //! INFO TEXT
                const Text("Fear not. We'll email you a recovery password"),
                const SizedBox(height: 20.0),
                //! EMAIL FIELD
                Padding(
                  padding: generalPadding,
                  child: Entry.email(emailController),
                ),
                const SizedBox(height: 5.0),
                //! ERROR TEXT
                Obx(() {
                  return Visibility(
                    visible: formController.errorMessage.value.isNotEmpty,
                    child: Text(
                      formController.errorMessage.value,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                    ),
                  );
                }),
                const SizedBox(height: 5.0),
                //! SIGN IN BUTTON
                Obx(() {
                  return LoadingButton(
                    text: "Reset Password",
                    condition: formController.processing.value,
                    onPressed: formController.missingField ||
                            formController.processing.value
                        ? null
                        : () => passwordReset(emailController.text.trim()),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
