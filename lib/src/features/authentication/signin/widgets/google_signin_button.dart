import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/widgets/loading_sheet.dart';
import '../controllers/google_signin_controller.dart';

class GoogleSigninButton extends ConsumerWidget {
  const GoogleSigninButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<GoogleSigninState>(googleSigninProvider, (previous, current) {
      if (current == GoogleSigninState.loading &&
          previous != GoogleSigninState.loading) {
        LoadingSheet.show(context);
      } else if (current == GoogleSigninState.error) {
        Navigator.of(context).maybePop();
        print("Google Sign In Error");
      } else {
        Navigator.of(context).maybePop();
      }
    });

    final image = Image.asset(
      "assets/google_logo.png",
      fit: BoxFit.scaleDown,
      width: 25,
    );
    const text = Text(
      'Sign In With Google',
      style: TextStyle(
        color: Color(0xFFD2CAF3),
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
      ),
    );

    return SizedBox(
      width: double.infinity,
      height: 55.0,
      child: GestureDetector(
        onTap: () => ref.read(googleSigninProvider.notifier).signinWithGoogle(),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [image, const SizedBox(width: 10), text],
          ),
        ),
      ),
    );
  }
}
