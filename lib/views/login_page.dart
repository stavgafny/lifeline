import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifeline/widgets/entry.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/email_password_auth.dart';

const generalPadding = EdgeInsets.symmetric(horizontal: 50.0);

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String authErrorMessage = "";
  bool processingLogin = false;

  bool get missingField {
    return _emailController.text.isEmpty || _passwordController.text.isEmpty;
  }

  signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final requirements =
        EmailPasswordAuth.validate(email: email, password: password);

    if (requirements.isEmpty) {
      setState(() => {processingLogin = true});
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
      } on FirebaseAuthException catch (e) {
        await Future.delayed(const Duration(seconds: 1)).then((value) {
          authErrorMessage = EmailPasswordAuth.getErrorMessage(e.code);
        });
      } finally {
        processingLogin = false;
      }
    } else {
      authErrorMessage = requirements.join("\n");
    }
    setState(() {});
  }

  @override
  void initState() {
    // Setting state because sign-in button listens to change in fields (missingField)
    _emailController.addListener(() => setState(() {}));
    _passwordController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  "Hi There!",
                  style: GoogleFonts.pacifico(fontSize: 42.0),
                ),
                //! INFO TEXT
                const Text("Looks Like You Aren't Iogged In"),
                const SizedBox(
                  height: 20.0,
                ),
                //! EMAIL FIELD
                Padding(
                  padding: generalPadding,
                  child: Entry.email(_emailController),
                ),
                const SizedBox(height: 10.0),
                //! PASSWORD FIELD
                Padding(
                  padding: generalPadding,
                  child: Entry.password(_passwordController),
                ),
                const SizedBox(height: 5.0),
                //! ERROR TEXT
                Visibility(
                  visible: authErrorMessage.isNotEmpty,
                  child: Text(
                    authErrorMessage,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                  ),
                ),
                const SizedBox(height: 5.0),
                //! SIGN IN BUTTON
                ElevatedButton(
                  // Disabled if fields are missing or processing request
                  onPressed: missingField || processingLogin ? null : signIn,
                  style: const ButtonStyle(
                    animationDuration: Duration(seconds: 0),
                    splashFactory: NoSplash.splashFactory,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: processingLogin
                        ? CircularProgressIndicator(
                            strokeWidth: 3.5,
                            color: Theme.of(context).colorScheme.primary,
                            backgroundColor:
                                Theme.of(context).colorScheme.surface,
                          )
                        : const Text("Sign In"),
                  ),
                ),
                const SizedBox(height: 10.0),
                //! REGISTER NOW TEXT
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Not a member?",
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Text(
                      " Register now",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14.0,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 25.0),
                //! GOOGLE SIGN IN BUTTON
                Container(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
