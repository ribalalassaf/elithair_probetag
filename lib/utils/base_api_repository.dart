import 'package:dio/dio.dart';
import 'package:elithair_probetag/utils/data_state.dart';

abstract class BaseApiRepository {
  Future<DataState<T>> sendRequest<T>({required Future<T> request}) async {
    try {
      final T response = await request;
      return DataSuccess(response);
    } on DioException catch (e) {
      String? message;

      return DataFailure(e.copyWith(message: message ?? "unexpected_error"));
    }
  }
}
