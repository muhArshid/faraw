import 'dart:convert';
import 'dart:io';
import 'package:farawlah_app/model/core/all_data_model.dart';
import 'package:http/http.dart' as http;

class ProductApi {
  static var client = http.Client();

  static Future<ProductList?> getData1() async {
    String url = 'https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad';
    var res = await client.post(Uri.parse(url));
    if (res.statusCode == 200) {
      //     return allDataFromJson(res.body);
    } else {
      return null;
    }
  }

  static Future<List<ProductList>> getData() async {
    try {
      List<ProductList>? servsResponse;
      HttpClient client = new HttpClient();
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      String url = 'https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad';

      Map map = {};

      HttpClientRequest request = await client.postUrl(Uri.parse(url));

      request.headers.set('content-type', 'application/json');

      request.add(utf8.encode(json.encode(map)));

      HttpClientResponse response = await request.close();

      if (response.statusCode == 200) {
        final String content = await response.transform(utf8.decoder).join();
        servsResponse = productFromJson(content);

        return servsResponse;
      }
      return servsResponse!;
    } catch (e) {
      rethrow;
    }
  }
}
