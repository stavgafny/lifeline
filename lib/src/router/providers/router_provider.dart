import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/authentication/shared/controllers/authentication_controller.dart';
import '../routes/app_routes.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final routerProvider = Provider.autoDispose<GoRouter>((ref) {
  final authenticationState = ref.watch(authenticationProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    initialLocation: AppRoutes.initial,
    routes: AppRoutes.routes,
    redirect: (context, state) {
      if (authenticationState.status == AuthenticationStatus.authenticated) {
        if (!authenticationState.user.emailVerified) {
          return AppRoutes.initial; //! VERIFY EMAIL
        }
        return AppRoutes.home;
      }
      if (AppRoutes.isNonAuthAllowed(state.location)) return state.location;
      return AppRoutes.signin;

      // if (authState.asData != null) {
      //   final user = authState.value!;
      //   if (user.verified) return AppRoutes.home;
      //   if (user.exist) return AppRoutes.initial;
      //   if (AppRoutes.isNonAuthAllowed(state.location)) return state.location;
      //   return AppRoutes.signin;
      // }
      // return null;
    },
  );
});
