import 'package:bloc/bloc.dart';
import 'package:elithair_probetag/features/medical_form_feature/business_logic/service.dart';
import 'package:elithair_probetag/features/medical_form_feature/model/form_model.dart';
import 'package:elithair_probetag/features/medical_form_feature/model/record_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'records_state.dart';
part 'records_cubit.freezed.dart';

@Injectable()
class RecordsCubit extends Cubit<RecordsState> {
  final GetRecordsService _getRecordsService;
  final AddRecordService _addRecordService;
  final AddRecordToLocalService _addRecordToLocalService;
  final GetLocalRecordsService _getLocalRecordsService;

  RecordsCubit(
    this._getRecordsService,
    this._addRecordService,
    this._addRecordToLocalService,
    this._getLocalRecordsService,
  ) : super(RecordsState.initial());

  void getRecords() async {
    emit(RecordsState.inProgress());
    final dataState = await _getRecordsService.call();
    final localRecords = _getLocalRecordsService.call();
    if (dataState.isSuccess()) {
      emit(RecordsState.recordsSuccess([...?dataState.data, ...localRecords]));
    } else {
      emit(RecordsState.failure());
    }
  }

  void addRecord(FormModel model) async {
    emit(RecordsState.inProgress());
    final dataState = await _addRecordService.call(model);
    if (dataState.isSuccess()) {
      await _addRecordToLocalService.call(RecordModel.fromForm(model));
      emit(RecordsState.success());
    } else {
      emit(RecordsState.failure());
    }
  }
}
