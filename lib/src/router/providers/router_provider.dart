import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../routes/app_routes.dart';
import './guards/auth_state_provider.dart';

final routerProvider = Provider.autoDispose<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    navigatorKey: AppRoutes.navigatorKeys.root,
    debugLogDiagnostics: true,
    initialLocation: AppRoutes.initial,
    routes: AppRoutes.routes,
    redirect: (context, state) {
      if (authState.status == AuthStatus.initialized) return null;
      if (authState.status == AuthStatus.authenticated) {
        if (!authState.user.emailVerified) return AppRoutes.emailVerification;
        if (state.location == AppRoutes.initial) return AppRoutes.home;
        return state.location;
      }
      if (AppRoutes.isNonAuthAllowed(state.location)) return state.location;
      return AppRoutes.signin;
    },
  );
});
