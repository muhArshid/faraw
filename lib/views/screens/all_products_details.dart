import 'dart:convert';

import 'package:farawlah_app/controller/product_controller.dart';
import 'package:farawlah_app/model/core/catogeries_model.dart';
import 'package:farawlah_app/model/core/product_modal_res.dart';
import 'package:farawlah_app/model/core/sub_catogeries_model_res.dart';
import 'package:farawlah_app/service/Network/http_constants.dart';
import 'package:farawlah_app/utils/AppColorCode.dart';
import 'package:farawlah_app/utils/AppFontOswald.dart';
import 'package:farawlah_app/widgets/dialog.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({Key? key}) : super(key: key);

  @override
  _AllProductsScreenState createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  int currentIndex = 1;
  bool isFeedLoading = false;
  final ScrollController _scrollController = ScrollController();
  ProductCtr ctr = Get.put(ProductCtr());

  ProductCtr proCtr = Get.find();

  bool isLoaded = true;
  int? mainCatId = 0;
  int? subCatId = 0;
  late Future<List<GetCategories>> listcategory;

  @override
  void initState() {
    proCtr.dataList.clear();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        currentIndex++;
        setState(() {
          isFeedLoading = true;
        });
        feedApiCall();
      }
    });
    feedApiCall();
    apiCallMainCat();

    super.initState();
  }

  List<GetCategories> dataList = <GetCategories>[];
  Future apiCallMainCat() async {
    final response = await http.get(
        Uri.https(HttpConstants.baseUrl, HttpConstants.catogeriesData),
        //  body: jsonEncode(body),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });
    if (response.statusCode == 200) {
      var getUsersData = json.decode(response.body) as List;
      setState(() {
        dataList = getUsersData.map((i) => GetCategories.fromJson(i)).toList();
      });
    } else {
      Get.dialog(errorDialog('Something went wrong'));
    }
  }

  List<GetSubCatogeries> subCatdataList = <GetSubCatogeries>[];
  Future apiCallSubCat(String? id) async {
    Map<String, String> queryParameters = {
      'parent_id': id!,
    };

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

      setState(() {
        subCatdataList =
            getData.map((i) => GetSubCatogeries.fromJson(i)).toList();
      });
    } else {
      Get.dialog(errorDialog('Something went wrong'));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  feedApiCall() async {
    await proCtr.apiCallAllProduct(mainCatId, subCatId, currentIndex);
    if (mounted) {
      setState(() {
        isFeedLoading = true;
        // isFetchingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<ProductCtr>(
          builder: (ct) => SafeArea(
            child: Stack(children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: appBar(
                  label: '',
                ),
              ),
              Positioned(
                top: 60,
                left: 0,
                right: 10,
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                      physics: const BouncingScrollPhysics(),
                      controller: _scrollController,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                children: const [
                                  Icon(
                                    Icons.money_rounded,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Icon(
                                    Icons.filter_alt,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 81.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10.h,
                                      child: Expanded(
                                        child: StaggeredGridView.countBuilder(
                                          scrollDirection: Axis.horizontal,
                                          crossAxisCount: 1,
                                          itemCount: dataList.length,
                                          shrinkWrap: true,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return mainCat(dataList[index]);
                                          },
                                          staggeredTileBuilder: (int index) =>
                                              const StaggeredTile.fit(2),
                                          mainAxisSpacing: 5.0,
                                          crossAxisSpacing: 1.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                      child: StaggeredGridView.countBuilder(
                                        scrollDirection: Axis.horizontal,
                                        crossAxisCount: 1,
                                        itemCount: subCatdataList.length,
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return subCat(subCatdataList[index]);
                                        },
                                        staggeredTileBuilder: (int index) =>
                                            const StaggeredTile.fit(2),
                                        mainAxisSpacing: 5.0,
                                        crossAxisSpacing: 1.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        isFeedLoading
                            ? ListView.builder(
                                itemCount: ct.dataList.length,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return products(ct.dataList[index]);
                                })
                            : const Center(
                                child: CircularProgressIndicator(
                                  color: AppColorCode.greenColor,
                                ),
                              )
                      ]),
                ),
              )
            ]),
          ),
        ));
  }

  Widget mainCat(GetCategories data) {
    return InkWell(
      onTap: () {
        proCtr.dataList.clear();
        apiCallSubCat(data.id.toString());
        setState(() {
          mainCatId = data.id;
        });
      },
      child: Container(
          height: 5.h,
          width: 10.w,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(5),
            color: data.id == mainCatId
                ? AppColorCode.greenColor
                : AppColorCode.pureWhite,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                data.name ?? ' ',
                style: AppFontMain(
                  color: data.id == mainCatId
                      ? AppColorCode.whiteshadow
                      : AppColorCode.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )),
    );
  }

  Widget subCat(GetSubCatogeries data) {
    return InkWell(
      onTap: () {
        proCtr.dataList.clear();
        setState(() {
          subCatId = data.id;
        });
        feedApiCall();
      },
      child: Container(
          height: 5.h,
          width: 10.w,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(5),
            color: data.id == subCatId
                ? AppColorCode.greenColor
                : AppColorCode.pureWhite,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                data.name ?? ' ',
                style: AppFontMain(
                  color: data.id == subCatId
                      ? AppColorCode.pureWhite
                      : AppColorCode.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )),
    );
  }

  Widget products(GetProducts data) {
    return Column(
      children: [
        const Divider(
          color: Colors.grey,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              data.images != null
                  ? SizedBox(
                      height: 15.h,
                      width: 23.w,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.images!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return image(data.images![index]);
                          }),
                    )
                  : Container(
                      child: Center(
                        child: Text(
                          'No Image',
                          style: AppFontMain(
                            color: AppColorCode.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      height: 15.h,
                      width: 23.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
              SizedBox(
                width: 1.w,
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name ?? '',
                      style: AppFontMain(
                        color: AppColorCode.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    data.offers != null
                        ? Row(
                            children: [
                              Text(data.offers!.discount.toString(),
                                  style: TextStyle(
                                    color: Colors.grey[300],
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: Colors.red,
                                    decorationStyle: TextDecorationStyle.solid,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(
                                width: .1.w,
                              ),
                              Container(
                                  margin: const EdgeInsets.all(15.0),
                                  padding: const EdgeInsets.all(1.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.red,
                                  ),
                                  child: Center(
                                    child: Center(
                                      child: Text(
                                        data.offers!.priceBook!.name ?? '',
                                        style: AppFontMain(
                                          color: AppColorCode.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ))
                            ],
                          )
                        : SizedBox(
                            height: 4.h,
                          ),
                    Text(
                      data.price.toString(),
                      style: AppFontMain(
                        color: Colors.green[200],
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              data.ratingsCount != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(
                          height: 62,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  proCtr.quantityAdd(
                                      data, data.ratingsCount! - 1);
                                },
                                child: const Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                  size: 30,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  data.ratingsCount.toString(),
                                  style: AppFontMain(
                                    color: AppColorCode.headerColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  proCtr.quantityAdd(
                                      data, data.ratingsCount! + 1);
                                },
                                child: const Icon(
                                  Icons.add_circle,
                                  color: Colors.green,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: InkWell(
                        onTap: () {
                          proCtr.quantityAdd(data, 1);
                          setState(() {});
                        },
                        child: const Icon(
                          Icons.add_circle,
                          color: Colors.green,
                          size: 30,
                        ),
                      ),
                    ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      proCtr.addfavourite(
                          data, data.isInWishListCount == 1 ? 0 : 1);
                    },
                    child: Icon(
                      data.isInWishListCount == 1
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      color: Colors.red,
                      size: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 52,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget image(Images? data) {
    return Container(
      height: 15.h,
      width: 23.w,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: Image.network(HttpConstants.imageUrl + data!.imageUrl!)
                as ImageProvider),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  Widget appBar({String? label}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {},
            child: const Center(
              child: Icon(
                Icons.stacked_bar_chart_sharp,
                color: Colors.red,
                size: 40,
              ),
            ),
          ),
          Text(
            'f',
            style: AppFontMain(
              color: AppColorCode.headerColor,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          InkWell(
            onTap: () {
              Get.back();
            },
            child: const Center(
              child: Icon(
                Icons.search,
                color: Colors.red,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
