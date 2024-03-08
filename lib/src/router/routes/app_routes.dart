import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/authentication/signin/signin_screen.dart';
import '../../features/authentication/signup/signup_screen.dart';
import '../../features/authentication/email_verification/email_verification_screen.dart';
import '../../features/authentication/forgot_password/forgot_password_screen.dart';
import '../../features/user/swipeable_screens/shell/shell_screen.dart'
    as user_swipeable_shell;
import '../../features/user/swipeable_screens/screens/home/home_screen.dart';
import '../../features/user/swipeable_screens/screens/dashboard/dashboard_screen.dart';
import '../../features/user/swipeable_screens/screens/timeline/timeline_screen.dart';

final _userShellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'u_shell');

class AppRoutes {
  static const String initial = "/";
  static const String error = "/error";
  static const String signin = "/signin";
  static const String signup = "/signup";
  static const String emailVerification = "/email-verification";
  static const String forgotPassword = "/forgot-password";
  static const String home = "/home";
  static const String dashboard = "/dashboard";
  static const String timeline = "/timeline";

  static const _nonAuthAllowed = <String>[
    signin,
    signup,
    forgotPassword,
  ];

  static isNonAuthAllowed(String route) => _nonAuthAllowed.contains(route);

  static List<RouteBase> routes = [
    GoRoute(
      path: initial,
      builder: (context, state) => const _Splash(),
    ),
    GoRoute(
      path: signin,
      builder: (context, state) => const SigninScreen(),
    ),
    GoRoute(
      path: signup,
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: emailVerification,
      builder: (context, state) => const EmailVerificationScreen(),
    ),
    GoRoute(
      path: forgotPassword,
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    ShellRoute(
      navigatorKey: _userShellNavigatorKey,
      pageBuilder: (context, state, child) => _buildShellTransitionPage(
        context: context,
        state: state,
        child: user_swipeable_shell.ShellScreen(
          body: child,
          location: state.location,
        ),
      ),
      routes: [
        GoRoute(
          path: home,
          pageBuilder: (context, state) => _buildShellTransitionPage(
            context: context,
            state: state,
            child: const HomeScreen(),
          ),
          parentNavigatorKey: _userShellNavigatorKey,
        ),
        GoRoute(
          path: dashboard,
          pageBuilder: (context, state) => _buildShellTransitionPage(
            context: context,
            state: state,
            child: const DashboardScreen(),
          ),
          parentNavigatorKey: _userShellNavigatorKey,
        ),
        GoRoute(
          path: timeline,
          pageBuilder: (context, state) => _buildShellTransitionPage(
            context: context,
            state: state,
            child: const TimelineScreen(),
          ),
          parentNavigatorKey: _userShellNavigatorKey,
        ),
      ],
    ),
  ];
}

class _Splash extends StatelessWidget {
  const _Splash();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

CustomTransitionPage _buildShellTransitionPage<T>({
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
