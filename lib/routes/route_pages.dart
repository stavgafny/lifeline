import 'package:get/get.dart';
import './initial_page.dart';
import '../views/login_page.dart';
import '../views/register_page.dart';
import '../views/home_page.dart';

const _pageTransition = Transition.fade;

class RoutePage {
  static const String initial = "/";
  static const String login = "/login";
  static const String register = "/register";
  static const String home = "/home";
}

final List<GetPage<dynamic>> routePages = [
  GetPage(
    name: RoutePage.initial,
    page: () => const InitialPage(),
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
    name: RoutePage.home,
    page: () => const HomePage(),
    transition: _pageTransition,
  ),
];
