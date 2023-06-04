import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authStream = FirebaseAuth.instance.authStateChanges();
Stream<User?> delayedStream = authStream.transform(
  StreamTransformer<User?, User?>.fromBind(
    (stream) => stream.asyncMap(
      (user) => Future<User?>.delayed(const Duration(seconds: 1), () => user),
    ),
  ),
);
final authProvider = StreamProvider<User?>((ref) {
  return delayedStream;
});
