import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weight_tracker_app/src/core/utils/view_state.dart';
import 'package:weight_tracker_app/src/repository/auth/auth_repository_impl.dart';
import 'package:weight_tracker_app/src/repository/weight/weight_repository_impl.dart';

import '../../../core/log_level.dart';
import '../../../core/navigation/navigation.dart';
import '../../../core/routes.dart';
import '../../../model/weight.dart';

final weightTrackerViewModel = StateNotifierProvider.autoDispose<
    WeightTrackerViewModel, WeightTrackerViewState>(
  (ref) => WeightTrackerViewModel(ref.read),
);

final weightListStreamProvider =
    StreamProvider.autoDispose<List<WeightDataModel>>((ref) {
  return ref.watch(weightRepository).getWeightListFromDB();
});

class WeightTrackerViewModel extends StateNotifier<WeightTrackerViewState> {
  final Reader _reader;

  WeightTrackerViewModel(this._reader)
      : super(WeightTrackerViewState.initial());

  /// Pass arguments to be used in editWeightView
  void saveSelectedWeightItem(WeightDataModel selectedWeightItem) {
    _reader(weightRepository)
        .setSelectedWeightItem(selectedWeight: selectedWeightItem);
    goToEditWeightItemView();
  }

  void goToEditWeightItemView() {
    _reader(navigationProvider).pushNamed(Routes.editWeightItemView);
  }

  Future<void> signOut() async {
    try {
      await _reader(authRepository).signOut();
      goToLoginView();
    } on FirebaseException catch (e) {
      log(e.toString(), level: LogLevel.error);
    }
  }

  void goToLoginView() {
    _reader(navigationProvider)
        .pushNamedAndRemoveUntil(Routes.loginView, (route) => false);
  }
}

class WeightTrackerViewState {
  final ViewState viewState;

  WeightTrackerViewState._({required this.viewState});

  factory WeightTrackerViewState.initial() =>
      WeightTrackerViewState._(viewState: ViewState.idle);

  WeightTrackerViewState copyWith({ViewState? viewState}) =>
      WeightTrackerViewState._(viewState: viewState ?? this.viewState);
}
