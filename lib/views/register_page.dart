import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/form_controller.dart';
import '../services/email_password_auth.dart';
import '../routes/route_pages.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/entry.dart';
import '../widgets/loading_button.dart';
import '../widgets/link_text.dart';

const generalPadding = EdgeInsets.symmetric(horizontal: 50.0);

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.delete<FormController>();

    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    final formController = Get.put(FormController(
        [emailController, passwordController, confirmPasswordController]));

    void unfocus() {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }

    void signUp(String email, String password, String confirmPassword) async {
      final requirements = EmailPasswordAuth.validate(
          email: email, password: password, confirmPassword: confirmPassword);
      if (requirements.isNotEmpty) {
        formController.setErrorMessage(requirements.join("\n"));
      } else {
        formController.setProcessing(true);
        String? response =
            await EmailPasswordAuth.signUp(email: email, password: password);
        if (response != null) {
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
                  "Create Account",
                  style: GoogleFonts.pacifico(fontSize: 42.0),
                ),
                //! INFO TEXT
                const Text("Lets sign you up"),
                const SizedBox(height: 20.0),
                //! EMAIL FIELD
                Padding(
                  padding: generalPadding,
                  child: Entry.email(emailController),
                ),
                const SizedBox(height: 10.0),
                //! PASSWORD FIELD
                Padding(
                  padding: generalPadding,
                  child: Entry.password(passwordController),
                ),
                const SizedBox(height: 10.0),
                //! CONFIRM PASSWORD FIELD
                Padding(
                  padding: generalPadding,
                  child:
                      Entry.password(confirmPasswordController, confirm: true),
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
                      maxLines: 3,
                    ),
                  );
                }),
                const SizedBox(height: 5.0),
                //! SIGN UP BUTTON
                Obx(() {
                  return LoadingButton(
                    text: "Sign Up",
                    condition: formController.processing.value,
                    onPressed: formController.missingField ||
                            formController.processing.value
                        ? null
                        : () => signUp(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                              confirmPasswordController.text.trim(),
                            ),
                  );
                }),
                const SizedBox(height: 10.0),
                //! REGISTER NOW TEXT
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Have an account? "),
                    LinkText(
                      "Sign in",
                      onTap: () {
                        unfocus();
                        Get.toNamed(RoutePage.login);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
