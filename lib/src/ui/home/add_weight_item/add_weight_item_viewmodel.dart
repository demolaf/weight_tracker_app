import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weight_tracker_app/src/core/utils/view_state.dart';
import 'package:weight_tracker_app/src/model/weight.dart';
import 'package:weight_tracker_app/src/repository/weight/weight_repository_impl.dart';

import '../../../core/log_level.dart';
import '../../../core/navigation/navigation.dart';

final addWeightItemViewModel = StateNotifierProvider.autoDispose<
    AddWeightItemViewModel, AddWeightItemViewState>(
  (ref) => AddWeightItemViewModel(ref.read),
);

class AddWeightItemViewModel extends StateNotifier<AddWeightItemViewState> {
  final Reader _reader;

  AddWeightItemViewModel(this._reader)
      : super(AddWeightItemViewState.initial());

  Future<void> addNewWeightToFirestore({required double weight}) async {
    state = state.copyWith(viewState: ViewState.loading);
    try {
      // get current time in milliseconds
      final int dateAdded = DateTime.now().millisecondsSinceEpoch;
      // add weight item to db
      await _reader(weightRepository)
          .addWeightToDB(WeightDataModel(weight: weight, dateAdded: dateAdded));
      goBack();
      log(DateTime.fromMillisecondsSinceEpoch(dateAdded).toLocal().toString(),
          level: LogLevel.debug);
    } on FirebaseException catch (e) {
      state = state.copyWith(viewState: ViewState.error);
      log(e.toString(), level: LogLevel.error);
    } finally {
      state = state.copyWith(viewState: ViewState.idle);
    }
  }

  void goBack() {
    _reader(navigationProvider).pop();
  }
}

class AddWeightItemViewState {
  final ViewState viewState;

  AddWeightItemViewState._({required this.viewState});

  factory AddWeightItemViewState.initial() =>
      AddWeightItemViewState._(viewState: ViewState.idle);

  AddWeightItemViewState copyWith({ViewState? viewState}) =>
      AddWeightItemViewState._(viewState: viewState ?? this.viewState);
}
