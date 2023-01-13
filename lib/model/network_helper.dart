import 'dart:developer';
import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;
  NetworkHelper({required this.url});

  Future<String> getWeather() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      return '';
    }
    final body = response.body;
    return body;
  }
}
