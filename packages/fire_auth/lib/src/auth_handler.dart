// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import './auth_user.dart';

class SignUpWithEmailAndPasswordException implements Exception {
  final String code;
  const SignUpWithEmailAndPasswordException(this.code);
}

class SignInWithEmailAndPasswordException implements Exception {
  final String code;
  const SignInWithEmailAndPasswordException(this.code);
}

class SendEmailVerificationException implements Exception {
  final String code;
  const SendEmailVerificationException(this.code);
}

class ForgotPasswordException implements Exception {
  final String code;
  const ForgotPasswordException(this.code);
}

class SignInWithGoogleException implements Exception {}

class SignOutException implements Exception {}

class SignUpWithEmailAndPasswordOptions {
  final String? name;
  final bool sendEmailVerification;
  SignUpWithEmailAndPasswordOptions({
    this.name,
    this.sendEmailVerification = false,
  });
}

class AuthHandler {
  final _firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn.standard();
  String? _onSignUpName;

  Future<void> reload() async => await _firebaseAuth.currentUser?.reload();

  Stream<AuthUser> get user {
    return _firebaseAuth.userChanges().map((firebaseUser) {
      return firebaseUser == null
          ? AuthUser.empty
          : AuthUser(
              id: firebaseUser.uid,
              email: firebaseUser.email,
              name: firebaseUser.displayName ?? _onSignUpName,
              emailVerified: firebaseUser.emailVerified,
              photoURL: firebaseUser.photoURL,
            );
    }).distinct(
      (previous, current) {
        return previous.id == current.id &&
            previous.emailVerified == current.emailVerified;
      },
    );
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    SignUpWithEmailAndPasswordOptions? options,
  }) async {
    try {
      _onSignUpName = options?.name;
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (options != null) {
        if (options.name != null) {
          userCredential.user?.updateDisplayName(options.name);
        }
        if (options.sendEmailVerification) {
          sendEmailVerification();
        }
      }
    } on FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordException(e.code);
    } finally {
      _onSignUpName = null;
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw SignInWithEmailAndPasswordException(e.code);
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      return await _firebaseAuth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw SendEmailVerificationException(e.code);
    }
  }

  Future<void> forgotPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ForgotPasswordException(e.code);
    }
  }

  Future<bool?> signInWithGoogle() async {
    try {
      final googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount == null) {
        throw SignInWithGoogleException();
      }

      final googleSignInAuth = await googleSignInAccount.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuth.accessToken,
        idToken: googleSignInAuth.idToken,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      return userCredential.additionalUserInfo?.isNewUser;
    } on FirebaseAuthException catch (_) {
      throw SignInWithGoogleException();
    }
  }

  Future<void> signOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (_) {
      throw SignOutException();
    }
  }
}
