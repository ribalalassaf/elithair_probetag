import 'package:elithair_probetag/features/medical_form_feature/business_logic/datasource.dart';
import 'package:elithair_probetag/features/medical_form_feature/model/form_model.dart';
import 'package:elithair_probetag/features/medical_form_feature/model/record_model.dart';
import 'package:elithair_probetag/utils/base_api_repository.dart';
import 'package:elithair_probetag/utils/data_state.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetRecordsService extends BaseApiRepository {
  final DataSource ds;
  GetRecordsService(this.ds);

  Future<DataState<List<RecordModel>>> call() {
    return sendRequest(request: ds.getRecords());
  }
}

@LazySingleton()
class AddRecordService extends BaseApiRepository {
  final DataSource ds;
  AddRecordService(this.ds);

  Future<DataState<void>> call(FormModel model) {
    return sendRequest(request: ds.addRecord(model));
  }
}
