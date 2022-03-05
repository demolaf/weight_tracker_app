import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weight_tracker_app/src/core/routes.dart';
import 'package:weight_tracker_app/src/repository/auth/auth_repository_impl.dart';

import '../../core/log_level.dart';

final startupViewModel = StateNotifierProvider<StartupViewModel, void>(
  (ref) => StartupViewModel(ref.read),
);

class StartupViewModel extends StateNotifier<void> {
  StartupViewModel(this._reader) : super(null);

  final Reader _reader;

  User? get currentUser => _reader(authRepository).currentUser;
}
