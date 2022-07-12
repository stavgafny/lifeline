import 'package:get/get.dart';
import 'initial_route_page.dart';
import '../views/auth/error_page.dart';
import '../views/auth/email_verification_page.dart';
import '../views/auth/login_page.dart';
import '../views/auth/register_page.dart';
import '../views/auth/forgot_password_page.dart';
import '../views/user/home_page.dart';

const _pageTransition = Transition.fade;

class RoutePage {
  static const String initial = "/";
  static const String error = "/error";
  static const String emailVerification = "/email_verification";
  static const String login = "/login";
  static const String register = "/register";
  static const String forgotPassword = "/forgot_password";
  static const String home = "/home";
}

final List<GetPage<dynamic>> routePages = [
  GetPage(
    name: RoutePage.initial,
    page: () => const InitialRoutePage(),
    transition: _pageTransition,
  ),
  GetPage(
    name: RoutePage.error,
    page: () => const ErrorPage(),
    transition: _pageTransition,
  ),
  GetPage(
    name: RoutePage.emailVerification,
    page: () => const EmailVerificationPage(),
    transition: _pageTransition,
  ),
  GetPage(
    name: RoutePage.login,
    page: () => const LoginPage(),
    transition: _pageTransition,
  ),
  GetPage(
    name: RoutePage.register,
    page: () => const RegisterPage(),
    transition: _pageTransition,
  ),
  GetPage(
    name: RoutePage.forgotPassword,
    page: () => const ForgotPasswordPage(),
    transition: _pageTransition,
  ),
  GetPage(
    name: RoutePage.home,
    page: () => const HomePage(),
    transition: _pageTransition,
  ),
];
