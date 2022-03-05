import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weight_tracker_app/src/core/log_level.dart';
import 'package:weight_tracker_app/src/core/routes.dart';
import 'package:weight_tracker_app/src/repository/auth/auth_repository_impl.dart';

import '../../../core/navigation/navigation.dart';
import '../../../core/utils/view_state.dart';

final loginViewModel =
    StateNotifierProvider.autoDispose<LoginViewModel, LoginViewState>(
  (ref) => LoginViewModel(ref.read),
);

class LoginViewModel extends StateNotifier<LoginViewState> {
  final Reader _reader;

  LoginViewModel(this._reader) : super(LoginViewState.initial());

  Future<void> loginAnonWithFirebase() async {
    state = state.copyWith(viewState: ViewState.loading);
    try {
      await _reader(authRepository).login();
      goToWeightTrackerView();
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(viewState: ViewState.error);
      log(e.toString(), level: LogLevel.error);
    } finally {
      state = state.copyWith(viewState: ViewState.idle);
    }
  }

  void goToWeightTrackerView() {
    _reader(navigationProvider)
        .pushNamedAndRemoveUntil(Routes.weightTrackerView, (_) => false);
  }
}

class LoginViewState {
  final ViewState viewState;

  const LoginViewState._({required this.viewState});

  // initial state of the view
  factory LoginViewState.initial() =>
      const LoginViewState._(viewState: ViewState.idle);

  // using the default state 'idle' if no new state
  LoginViewState copyWith({ViewState? viewState}) =>
      LoginViewState._(viewState: viewState ?? this.viewState);
}
