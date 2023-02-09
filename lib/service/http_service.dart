import 'package:http/http.dart' as http;

class HttpService {
  static Future<http.Response> getRequest(String category) async {
    var baseUrl =
        "https://api.pexels.com/v1/search?query=$category&per_page=80&page=1";
    http.Response response;

    final url = Uri.parse(baseUrl);

    try {
      response = await http.get(url, headers: {
        "Authorization":
            "563492ad6f91700001000001626d71d300594df295d0d196b821df75"
      });
    } on Exception {
      rethrow;
    }

    return response;
  }
}
