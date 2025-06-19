import 'package:hive/hive.dart';
part 'record_model.g.dart';

@HiveType(typeId: 0)
class RecordModel {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final DateTime? submittedAt;
  @HiveField(2)
  final List<String>? conditions;
  @HiveField(3)
  final bool? priorTransplant;

  RecordModel({this.id, this.submittedAt, this.conditions, this.priorTransplant});

  factory RecordModel.fromJson(Map<String, dynamic> json) => RecordModel(
    id: json["id"],
    submittedAt: json["submittedAt"] == null ? null : DateTime.parse(json["submittedAt"]),
    conditions: json["conditions"] == null ? [] : List<String>.from(json["conditions"]!.map((x) => x)),
    priorTransplant: json["priorTransplant"],
  );
}
