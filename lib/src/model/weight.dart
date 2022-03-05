import 'package:cloud_firestore/cloud_firestore.dart';

/// Weight Model
class WeightDataModel {
  String? id;
  double? weight;
  int? dateAdded;

  WeightDataModel({this.id, this.weight, this.dateAdded});

  WeightDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    weight = json['weight'];
    dateAdded = json['date_added'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['weight'] = weight;
    data['date_added'] = dateAdded;
    return data;
  }
}
