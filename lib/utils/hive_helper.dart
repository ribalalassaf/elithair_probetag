import 'package:elithair_probetag/features/medical_form_feature/model/record_model.dart';
import 'package:elithair_probetag/utils/constants.dart';
import 'package:hive_flutter/adapters.dart';

class HiveHelper {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(RecordModelAdapter());
    await Hive.openBox<RecordModel>(recordsBoxName);
  }
}
