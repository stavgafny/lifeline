import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/form_controller.dart';
import '../services/email_password_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/entry.dart';
import '../widgets/link_text.dart';

const generalPadding = EdgeInsets.symmetric(horizontal: 50.0);

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    Get.delete<FormController>();
    final formController = Get.put(FormController(
        [emailController, passwordController, confirmPasswordController]));

    signUp(String email, String password, String confirmPassword) async {
      final requirements = EmailPasswordAuth.validate(
          email: email, password: password, confirmPassword: confirmPassword);
      if (requirements.isNotEmpty) {
        formController.setErrorMessage(requirements.join("\n"));
      } else {
        formController.setProcessing(true);
        String? response = await EmailPasswordAuth.signUp(email, password);
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
                const SizedBox(
                  height: 20.0,
                ),
                //! EMAIL FIELD
                Padding(
                  padding: generalPadding,
                  child: Entry.email(emailController),
                ),
                const SizedBox(height: 10.0),
                //! PASSWORD FIELD
                Padding(
                  padding: generalPadding,
                  child: Entry.password(
                    passwordController,
                    autofillHints: false,
                  ),
                ),
                const SizedBox(height: 10.0),
                //! CONFIRM PASSWORD FIELD
                Padding(
                  padding: generalPadding,
                  child: Entry.password(
                    confirmPasswordController,
                    confirm: true,
                    autofillHints: false,
                  ),
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
                  return ElevatedButton(
                    // Disabled if fields are missing or processing request
                    onPressed: formController.missingField ||
                            formController.processing.value
                        ? null
                        : () => signUp(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                              confirmPasswordController.text.trim(),
                            ),
                    style: const ButtonStyle(
                      animationDuration: Duration(seconds: 0),
                      splashFactory: NoSplash.splashFactory,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: formController.processing.value
                          ? CircularProgressIndicator(
                              strokeWidth: 3.5,
                              color: Theme.of(context).colorScheme.primary,
                              backgroundColor:
                                  Theme.of(context).colorScheme.surface,
                            )
                          : const Text("Sign Up"),
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
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
