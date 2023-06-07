import 'package:flutter/material.dart';

class GoogleSigninButton extends StatelessWidget {
  const GoogleSigninButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55.0,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                child: Image.asset(
                  "assets/google_logo.png",
                  fit: BoxFit.scaleDown,
                  width: 25,
                ),
              ),
              const Center(
                child: Text(
                  'Sign In With Google',
                  style: TextStyle(
                    color: Color(0xFFD2CAF3),
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
