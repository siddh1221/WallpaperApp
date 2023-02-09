import 'dart:convert';
import 'dart:io';

import '../service/http_service.dart';

class WallPaperRepository {
  getWallPaper(String category) async {
    List wallpaperData = [];
    try {
      final response = await HttpService.getRequest(category);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        // final result = walpaperResponseFromJson(response.body);
        jsonData['photos'].forEach((e) {
          wallpaperData.add(e);
        });
        return wallpaperData;
      } else {
        return null;
      }
    } on SocketException {
      rethrow;
    } on HttpException {
      rethrow;
    } on FormatException {
      rethrow;
    }
  }
}
