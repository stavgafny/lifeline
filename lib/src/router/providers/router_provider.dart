import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/authentication/shared/controllers/auth_controller.dart';
import '../routes/app_routes.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final routerProvider = Provider.autoDispose<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    initialLocation: AppRoutes.initial,
    routes: AppRoutes.routes,
    redirect: (context, state) {
      if (authState.status == AuthStatus.initialized) return null; //! SPLASH
      if (authState.status == AuthStatus.authenticated) {
        if (!authState.user.emailVerified) {
          return AppRoutes.home; //! VERIFY EMAIL
        }
        return AppRoutes.home;
      }
      if (AppRoutes.isNonAuthAllowed(state.location)) return state.location;
      return AppRoutes.signin;
    },
  );
});
