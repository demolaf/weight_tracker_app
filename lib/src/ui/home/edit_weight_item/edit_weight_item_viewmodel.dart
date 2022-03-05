import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weight_tracker_app/src/model/weight.dart';

import '../../../core/log_level.dart';
import '../../../core/navigation/navigation.dart';
import '../../../core/utils/view_state.dart';
import '../../../repository/weight/weight_repository_impl.dart';

final editWeightItemViewModel = StateNotifierProvider.autoDispose<
    EditWeightItemViewModel, EditWeightItemViewState>(
  (ref) => EditWeightItemViewModel(ref.read),
);

class EditWeightItemViewModel extends StateNotifier<EditWeightItemViewState> {
  final Reader _reader;

  WeightDataModel? get selectedWeight =>
      _reader(weightRepository).selectedWeight;

  EditWeightItemViewModel(this._reader)
      : super(EditWeightItemViewState.initial());

  Future<void> updateSelectedWeightItem({required double weight}) async {
    state = state.copyWith(viewState: ViewState.loading);
    try {
      // get current time in milliseconds
      final int newDateAdded = DateTime.now().millisecondsSinceEpoch;

      // update weight item in db
      await _reader(weightRepository)
          .updateWeightInDB(weight: weight, newDateAdded: newDateAdded);
      goBack();
      log(
          DateTime.fromMillisecondsSinceEpoch(newDateAdded)
              .toLocal()
              .toString(),
          level: LogLevel.debug);
    } on FirebaseException catch (e) {
      state = state.copyWith(viewState: ViewState.error);
      log(e.toString(), level: LogLevel.error);
    } finally {
      state = state.copyWith(viewState: ViewState.idle);
    }
  }

  Future<void> deleteSelectedWeightItem() async {
    try {
      // delete weight item in db
      await _reader(weightRepository).deleteWeightInDB();
      goBack();
    } on Exception catch (e) {
      log(e.toString(), level: LogLevel.error);
    } finally {}
  }

  void goBack() {
    _reader(navigationProvider).pop();
  }
}

class EditWeightItemViewState {
  final ViewState viewState;

  EditWeightItemViewState._({required this.viewState});

  factory EditWeightItemViewState.initial() =>
      EditWeightItemViewState._(viewState: ViewState.idle);

  EditWeightItemViewState copyWith({ViewState? viewState}) =>
      EditWeightItemViewState._(viewState: viewState ?? this.viewState);
}
