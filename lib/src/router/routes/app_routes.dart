import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/authentication/signin/signin_screen.dart';
import '../../features/authentication/signup/signup_screen.dart';
import '../../features/authentication/email_verification/email_verification_screen.dart';
import '../../features/authentication/forgot_password/forgot_password_screen.dart';
import '../../features/user/swipeable_screens/screens/home/home_screen.dart';
import '../../features/user/swipeable_screens/screens/dashboard/dashboard_screen.dart';
import '../../features/user/swipeable_screens/screens/timeline/timeline_screen.dart';

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
        builder: (context, state, child) {
          return NavigationScaffold(body: child, location: state.location);
        },
        routes: [
          GoRoute(
            path: home,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: dashboard,
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: timeline,
            builder: (context, state) => const TimelineScreen(),
          ),
        ]),
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

class NavigationScaffold extends StatefulWidget {
  final Widget body;
  final String location;
  const NavigationScaffold({
    super.key,
    required this.body,
    required this.location,
  });

  @override
  State<NavigationScaffold> createState() => _NavigationScaffoldState();
}

class _NavigationScaffoldState extends State<NavigationScaffold> {
  @override
  Widget build(BuildContext context) {
    final selected = widget.location == AppRoutes.dashboard
        ? 0
        : widget.location == AppRoutes.timeline
            ? 2
            : 1;

    return Scaffold(
      body: widget.body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selected,
        destinations: [
          NavigationDestination(
            label: 'Dashboard',
            icon: IconButton(
              icon: const Icon(Icons.dashboard),
              onPressed: () {
                context.go(AppRoutes.dashboard);
              },
            ),
          ),
          NavigationDestination(
            label: 'Home',
            icon: IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                context.go(AppRoutes.home);
              },
            ),
          ),
          NavigationDestination(
            label: 'Timeline',
            icon: IconButton(
              icon: const Icon(Icons.timeline),
              onPressed: () {
                context.go(AppRoutes.timeline);
              },
            ),
          ),
        ],
      ),
    );
  }
}
