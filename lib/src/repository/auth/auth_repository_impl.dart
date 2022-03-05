import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weight_tracker_app/src/core/log_level.dart';
import 'package:weight_tracker_app/src/repository/auth/auth.dart';

final authRepository = Provider<Auth>(
  (ref) {
    return AuthRepositoryImpl(firebaseAuth: FirebaseAuth.instance);
  },
);

/// provide the auth repository/service/functionality, depending on the
/// abstract class Auth
class AuthRepositoryImpl implements Auth {
  FirebaseAuth firebaseAuth;

  @override
  User? get currentUser => firebaseAuth.currentUser;

  AuthRepositoryImpl({required this.firebaseAuth});

  @override
  Future<void> login() async {
    UserCredential userCredential = await firebaseAuth.signInAnonymously();
    log('${userCredential.user?.uid}', level: LogLevel.debug);
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
