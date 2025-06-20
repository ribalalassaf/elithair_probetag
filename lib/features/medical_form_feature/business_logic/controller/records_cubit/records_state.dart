part of 'records_cubit.dart';

@freezed
class RecordsState with _$RecordsState {
  const factory RecordsState.initial() = _Initial;
  const factory RecordsState.inProgress() = _InProgress;
  const factory RecordsState.recordsSuccess(List<RecordModel> records) = _RecordsSuccess;
  const factory RecordsState.success() = _Success;
  const factory RecordsState.failure() = _Failure;
}
