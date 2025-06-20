import 'package:elithair_probetag/features/medical_form_feature/model/record_model.dart';
import 'package:elithair_probetag/utils/constants.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class LocalDatasource {
  Box<RecordModel> recordsBox = Hive.box<RecordModel>(recordsBoxName);

  Future<void> addRecord(RecordModel record) async {
    await recordsBox.add(record);
  }

  List<RecordModel> getRecords() {
    return recordsBox.values.toList();
  }
}
