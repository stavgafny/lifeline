import 'package:fire_auth/fire_auth.dart';
import 'package:flutter/material.dart';

class UserService {
  static void _precacheUserImage(String? photoURL, BuildContext context) {
    if (photoURL == null) return;
    precacheImage(NetworkImage(photoURL), context);
  }

  static void onUserInit(AuthUser user, BuildContext context) {
    _precacheUserImage(user.photoURL, context);
  }
}
