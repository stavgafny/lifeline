import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/form_controller.dart';
import '../../routes/route_pages.dart';
import '../../services/email_password_auth.dart';
import '../../services/google_auth.dart';
import '../../widgets/entry.dart';
import '../../widgets/loading_button.dart';
import '../../widgets/link_text.dart';

const generalPadding = EdgeInsets.symmetric(horizontal: 50.0);

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.delete<FormController>();

    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    final formController =
        Get.put(FormController([emailController, passwordController]));

    void unfocus() {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }

    void signIn(String email, String password) async {
      final requirements =
          EmailPasswordAuth.validate(email: email, password: password);
      if (requirements.isNotEmpty) {
        formController.setErrorMessage(requirements.join("\n"));
      } else {
        formController.setProcessing(true);
        String? response =
            await EmailPasswordAuth.signIn(email: email, password: password);
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
                  "Hi There!",
                  style: GoogleFonts.pacifico(fontSize: 42.0),
                ),
                //! INFO TEXT
                const Text("Looks like you aren't logged in"),
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
                //! FORGOT PASSWORD LINK
                Padding(
                  padding: generalPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      LinkText(
                        "Forgot password?",
                        onTap: () {
                          unfocus();
                          Get.toNamed(RoutePage.forgotPassword);
                        },
                      ),
                    ],
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
                      maxLines: 2,
                    ),
                  );
                }),
                const SizedBox(height: 5.0),
                //! SIGN IN BUTTON
                Obx(() {
                  return LoadingButton(
                    text: "Sign In",
                    condition: formController.processing.value,
                    onPressed: formController.missingField ||
                            formController.processing.value
                        ? null
                        : () => signIn(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                            ),
                  );
                }),
                const SizedBox(height: 10.0),
                //! REGISTER NOW TEXT & LINK
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Not a member yet? "),
                    LinkText(
                      "Sign up",
                      onTap: () {
                        unfocus();
                        Get.toNamed(RoutePage.register);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 25.0),
                //! GOOGLE SIGN IN BUTTON
                GestureDetector(
                  onTap: () => GoogleAuth.signIn(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Image.asset(
                            "assets/google_logo.png",
                            fit: BoxFit.scaleDown,
                            width: 25,
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Sign in with Google',
                            style: TextStyle(
                              color: Color(0xFFD2CAF3),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
