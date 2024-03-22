import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomPageTransitions {
  static CustomTransitionPage shell<T>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      transitionDuration: const Duration(milliseconds: 300),
      barrierColor: Theme.of(context).scaffoldBackgroundColor,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
        child: child,
      ),
    );
  }
}
