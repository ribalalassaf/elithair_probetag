import 'package:dio/dio.dart';
import 'package:elithair_probetag/utils/dio_interceptors.dart';
import 'package:injectable/injectable.dart';

@module
abstract class Modules {
  @LazySingleton()
  Dio get dio => Dio()..interceptors.addAll([LoggingInterceptor()]);
}
