import 'dart:convert';
import 'dart:io';

import 'package:farawlah_app/model/core/all_data_model.dart';
import 'package:farawlah_app/model/core/product_modal_res.dart';
import 'package:farawlah_app/service/API/service.dart';
import 'package:farawlah_app/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductCtr extends GetxController {
  List<GetProducts> dataList = <GetProducts>[];
  List<ProductList> allDataList = <ProductList>[];

  List<ProductList> data = <ProductList>[].obs;
  String? mainCatId;
  List<ProductList>? allData;
  List<CategoryDishes>? item;
  List<CategoryDishes> cartItem = <CategoryDishes>[];
  List<TableMenuList> allTableDataList = <TableMenuList>[];
  updateId(String id) {
    mainCatId = id;
    update();
  }

  RxDouble totalAmount = 0.0.obs;
  RxInt totalItem = 0.obs;
  void additem(int num) {
    totalItem.value = totalItem.value + num;
    update();
  }

  void removeItem(int amount) {
    totalItem.value = totalItem.value - amount;
    update();
  }

  void addAmount(double amount) {
    totalAmount.value = totalAmount.value + amount;
  }

  void removeAmount(double amount) {
    totalAmount.value = totalAmount.value - amount;
  }

  void totalZero(double value) {
    totalAmount.value = value;
  }

  void itemZero(int value) {
    totalItem.value = value;
  }

  updateItem(List<CategoryDishes> data) {
    item = data;
    update();
  }

  // Rxn<List<CategoryDishes>> mainCatList =
  //     Rxn<List<CategoryDishes>>([]);
  List<CategoryDishes> cartList = [];
  addCartList(CategoryDishes data) {
    final index =
        cartList.indexWhere((element) => element.dishId == data.dishId);
    if (index < 0) {
      cartList.add(data);
    }
  }

  cartUpdateItem(CategoryDishes data, int count) {
    if (count <= -1) {
      deleteCartList(data.dishId!);
    } else {
      data.counter = count;
      Get.snackbar("Item Update", "${data.dishName}  your cart");
      update();
    }
  }

  deleteCartList(String id) {
    cartList.removeWhere((element) => element.dishId == id);
    Get.snackbar("Item ", " was remove to your cart");
    update();
  }

  getAllData() async {
    allData = await ProductApi.getData();
    allTableDataList = allTableDataList + allData![0].tableMenuList!;
    item = allTableDataList[0].categoryDishes;
    mainCatId = allTableDataList[0].menuCategoryId;
    update();
  }

  // getIdWithData() {
  //   item = allTableDataList.categoryDishes
  //       .firstWhere((element) => element.menuCategoryId == mainCatId)
  //       .toList();
  // }

  Future apiCallAll() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    String url = 'https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad';

    Map map = {};

    HttpClientRequest request = await client.postUrl(Uri.parse(url));

    request.headers.set('content-type', 'application/json');

    request.add(utf8.encode(json.encode(map)));

    HttpClientResponse response = await request.close();

    //     Uri.https(
    //         HttpConstants.baseurl, HttpConstants.getAlldata, queryParameters),
    //     //body: jsonEncode(body),
    //     headers: {
    //       "Accept": "application/json",
    //       "content-type": "application/json"
    //     });

    if (response.statusCode == 200) {
      var getData = await response.transform(utf8.decoder).join() as dynamic;

      var data = getData.map((i) => ProductList.fromJson(i)).toList();
      allDataList = allDataList + data;
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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }
}
