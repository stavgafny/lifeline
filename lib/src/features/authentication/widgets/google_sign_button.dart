import 'package:flutter/material.dart';

class GoogleSignButton extends StatelessWidget {
  const GoogleSignButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/google_logo.png",
                fit: BoxFit.scaleDown,
                width: 25,
              ),
              const SizedBox(width: 14),
              const Text(
                'Sign in with Google',
                style: TextStyle(
                  color: Color(0xFFD2CAF3),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// Wrap(
//           crossAxisAlignment: WrapCrossAlignment.center,
//           children: [
//             Image.asset(
//               "assets/google_logo.png",
//               fit: BoxFit.scaleDown,
//               width: 25,
//             ),
//             const SizedBox(width: 12),
//             const Text(
//               'Sign in with Google',
//               style: TextStyle(
//                 color: Color(0xFFD2CAF3),
//               ),
//             ),
//           ],
//         ),