import 'package:firebase_auth/firebase_auth.dart';

/// Auth
abstract class Auth {
  /// To get persisted current user from firebase auth
  User? get currentUser;

  /// Login anonymously using firebase auth
  Future<void> login();

  /// sign out user using firebase auth
  Future<void> signOut();
}
