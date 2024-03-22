import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import './core/splash_screen.dart';
import './core/custom_page_transitions.dart';
import '../../features/authentication/signin/signin_screen.dart';
import '../../features/authentication/signup/signup_screen.dart';
import '../../features/authentication/email_verification/email_verification_screen.dart';
import '../../features/authentication/forgot_password/forgot_password_screen.dart';
import '../../features/user/swipeable_screens/shell/shell_screen.dart'
    as user_swipeable_shell;
import '../../features/user/swipeable_screens/screens/home/home_screen.dart';
import '../../features/user/swipeable_screens/screens/dashboard/dashboard_screen.dart';
import '../../features/user/swipeable_screens/screens/timeline/timeline_screen.dart';

class _NavigatorKeys {
  static _NavigatorKeys instance = _NavigatorKeys._();

  final root = GlobalKey<NavigatorState>(debugLabel: 'root');
  final userShell = GlobalKey<NavigatorState>(debugLabel: 'u_shell');

  _NavigatorKeys._();
}

class AppRoutes {
  static final navigatorKeys = _NavigatorKeys.instance;

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
      parentNavigatorKey: navigatorKeys.root,
      path: initial,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      parentNavigatorKey: navigatorKeys.root,
      path: signin,
      builder: (context, state) => const SigninScreen(),
    ),
    GoRoute(
      parentNavigatorKey: navigatorKeys.root,
      path: signup,
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      parentNavigatorKey: navigatorKeys.root,
      path: emailVerification,
      builder: (context, state) => const EmailVerificationScreen(),
    ),
    GoRoute(
      parentNavigatorKey: navigatorKeys.root,
      path: forgotPassword,
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    ShellRoute(
      navigatorKey: navigatorKeys.userShell,
      pageBuilder: (context, state, child) => CustomPageTransitions.shell(
        context: context,
        state: state,
        child: user_swipeable_shell.ShellScreen(
          body: child,
          location: state.location,
        ),
      ),
      routes: [
        GoRoute(
          parentNavigatorKey: navigatorKeys.userShell,
          path: home,
          pageBuilder: (context, state) => CustomPageTransitions.shell(
            context: context,
            state: state,
            child: const HomeScreen(),
          ),
        ),
        GoRoute(
          parentNavigatorKey: navigatorKeys.userShell,
          path: dashboard,
          pageBuilder: (context, state) => CustomPageTransitions.shell(
            context: context,
            state: state,
            child: const DashboardScreen(),
          ),
        ),
        GoRoute(
          parentNavigatorKey: navigatorKeys.userShell,
          path: timeline,
          pageBuilder: (context, state) => CustomPageTransitions.shell(
            context: context,
            state: state,
            child: const TimelineScreen(),
          ),
        ),
      ],
    ),
  ];
}
