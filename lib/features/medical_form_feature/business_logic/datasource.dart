import 'package:dio/dio.dart';
import 'package:elithair_probetag/features/medical_form_feature/model/form_model.dart';
import 'package:elithair_probetag/features/medical_form_feature/model/record_model.dart';
import 'package:elithair_probetag/utils/urls.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class DataSource {
  final Dio _dio;
  DataSource(this._dio);

  Future<List<RecordModel>> getRecords() async {
    final response = await _dio.get(medicalHistoryUrl);
    return List<RecordModel>.from(response.data.map((element) => RecordModel.fromJson(element)));
  }

  Future<void> addRecord(FormModel model) async {
    await _dio.post(medicalHistoryUrl, data: model.toJson());
  }
}
