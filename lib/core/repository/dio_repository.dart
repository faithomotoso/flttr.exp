import 'package:dio/dio.dart';

class DioRepository {
  static DioRepository instance = DioRepository();

  final Dio dio = Dio();
}