import 'package:http/http.dart';

class HttpRepository {
  static HttpRepository instance = HttpRepository();

  final Client client = Client();
}
