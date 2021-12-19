import 'dart:convert';

import 'package:farawlah_app/model/core/product_modal_res.dart';
import 'package:farawlah_app/service/Network/http_constants.dart';
import 'package:farawlah_app/widgets/dialog.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductCtr extends GetxController {
  List<GetProducts> dataList = <GetProducts>[];

  Future apiCallAllProduct(int? mainid, subid, offset) async {
    Map<String, String> queryParameters = {
      'parent_category_id': subid.toString(),
      'parent_id': mainid.toString(),
      'store_id': '2',
      'offset': offset.toString(),
      'limit': '20',
      'sort_type': 'DESC'
    };
    print(queryParameters);
    final response = await http.get(
        Uri.https(HttpConstants.baseUrl, HttpConstants.subcatogeriesData,
            queryParameters),
        //body: jsonEncode(body),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });

    if (response.statusCode == 200) {
      var getData = json.decode(response.body) as List;

      var data = getData.map((i) => GetProducts.fromJson(i)).toList();
      dataList = dataList + data;
      update();
    } else {
      Get.dialog(errorDialog('Something went wrong'));
    }
  }

  addfavourite(GetProducts getProducts, int id) {
    getProducts.isInWishListCount = id;
    update();
  }

  quantityAdd(GetProducts getProducts, int quantity) {
    getProducts.ratingsCount = quantity;
    update();
  }
}
