import 'package:fire_auth/fire_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepoProvider = Provider<AuthHandler>((_) => AuthHandler());
