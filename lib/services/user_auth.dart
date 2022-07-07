import 'package:firebase_auth/firebase_auth.dart';

class UserAuth {
  static User? get user => FirebaseAuth.instance.currentUser;

  static bool get exist => UserAuth.user != null;

  static bool get verified =>
      UserAuth.exist ? UserAuth.user!.emailVerified : false;

  static Future reload() async {
    if (UserAuth.exist) {
      await UserAuth.user!.reload();
    }
  }

  static void signOut() {
    FirebaseAuth.instance.signOut();
  }
}
