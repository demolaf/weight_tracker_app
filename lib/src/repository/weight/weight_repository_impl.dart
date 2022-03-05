import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weight_tracker_app/src/core/constants/firestore_collections.dart';
import 'package:weight_tracker_app/src/model/weight.dart';
import 'package:weight_tracker_app/src/repository/auth/auth_repository_impl.dart';
import 'package:weight_tracker_app/src/repository/weight/weight.dart';

import '../../core/log_level.dart';
import '../auth/auth.dart';

final weightRepository = Provider<Weight>(
  (ref) {
    return WeightRepositoryImpl(
        firestore: FirebaseFirestore.instance, auth: ref.watch(authRepository));
  },
);

class WeightRepositoryImpl implements Weight {
  final Auth auth;
  final FirebaseFirestore firestore;
  WeightDataModel? _selectedWeight;

  WeightRepositoryImpl({
    required this.firestore,
    required this.auth,
  });

  // creating a getter function to get weight collection reference to avoid
  // repeating this block of code to carryout task
  CollectionReference<Map<String, dynamic>> get _weightCollectionRef =>
      firestore
          .collection(FirestoreCollections.usersCollection)
          .doc(auth.currentUser?.uid)
          .collection(FirestoreCollections.weightCollection);

  @override
  Stream<List<WeightDataModel>> getWeightListFromDB() => _weightCollectionRef
      .snapshots()
      .map((querySnapshot) => querySnapshot.docs.map(
            (queryDocumentSnapshot) {
              log('Selected weight list ${queryDocumentSnapshot.data()} id ${queryDocumentSnapshot.id}',
                  level: LogLevel.debug);
              return WeightDataModel(
                  weight: queryDocumentSnapshot.data()['weight'],
                  dateAdded: queryDocumentSnapshot.data()['date_added'],
                  id: queryDocumentSnapshot.id);
            },
          ).toList());

  @override
  WeightDataModel? get selectedWeight => _selectedWeight;

  @override
  Future<DocumentReference<Map<String, dynamic>>> addWeightToDB(
      WeightDataModel weight) async {
    //TODO: change the return type here
    return await _weightCollectionRef.add(weight.toJson());
  }

  @override
  Future<void> updateWeightInDB(
      {required double weight, required int newDateAdded}) async {
    log('Selected weight id ${selectedWeight?.id}', level: LogLevel.error);
    return await _weightCollectionRef.doc(selectedWeight?.id).update(
        WeightDataModel(weight: weight, dateAdded: newDateAdded).toJson());
  }

  @override
  Future<void> deleteWeightInDB() async {
    log('Selected weight id ${selectedWeight?.id}', level: LogLevel.error);
    return await _weightCollectionRef.doc(_selectedWeight?.id).delete();
  }

  @override
  void setSelectedWeightItem({required WeightDataModel selectedWeight}) {
    _selectedWeight = selectedWeight;
    log('Selected weight id ${selectedWeight.id}', level: LogLevel.error);
  }
}
