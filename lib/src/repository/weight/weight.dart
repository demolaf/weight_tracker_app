import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/weight.dart';

abstract class Weight {
  /// get list of weight objects from firestore database as a stream
  Stream<List<WeightDataModel>> getWeightListFromDB();

  /// add a new weight object to firestore database using [WeightDataModel] weight
  Future<DocumentReference<Map<String, dynamic>>> addWeightToDB(
      WeightDataModel weight);

  /// update an existing weight object in database using [double] weight,
  /// [int] newDateAdded and [String] weightId
  Future<void> updateWeightInDB(
      {required double weight, required int newDateAdded});

  /// delete an existing weight object in database using [String] weightId
  Future<void> deleteWeightInDB();

  /// get selected weight item
  WeightDataModel? get selectedWeight;

  /// set selected weight item
  setSelectedWeightItem({required WeightDataModel selectedWeight});
}
