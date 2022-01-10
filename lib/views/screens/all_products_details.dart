import 'package:farawlah_app/controller/product_controller.dart';
import 'package:farawlah_app/model/core/all_data_model.dart';
import 'package:farawlah_app/model/core/catogeries_model.dart';
import 'package:farawlah_app/utils/AppColorCode.dart';
import 'package:farawlah_app/utils/AppFontOswald.dart';
import 'package:farawlah_app/views/screens/product/cart_item.dart';
import 'package:farawlah_app/views/screens/product/widget/drawer.dart';
import 'package:farawlah_app/views/screens/product/widget/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:badges/badges.dart';

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
    apiCall();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  apiCall() async {
    await proCtr.getAllData();
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
        key: proCtr.scaffoldKey,
        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.white,
          ),
          child: drawer(context),
        ),
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
                          child: SizedBox(
                            height: 6.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              //   crossAxisCount: 1,
                              itemCount: ct.allTableDataList.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return mainCat(ct.allTableDataList[index]);
                              },
                            ),
                          ),
                        ),
                        isFeedLoading
                            ? ListView.builder(
                                itemCount: ct.item!.length,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return ProductWidget(
                                      data: ct.item![index], index: index);
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

  Widget mainCat(TableMenuList data) {
    return InkWell(
      onTap: () {
        proCtr.updateId(data.menuCategoryId!);
        proCtr.updateItem(data.categoryDishes!);
        setState(() {});
      },
      child: Builder(builder: (context) {
        return SizedBox(
          height: 13,
          width: 150,
          child: Column(
            children: [
              Text(
                data.menuCategory ?? ' ',
                style: AppFontMain(
                  color: data.menuCategoryId == ctr.mainCatId
                      ? Colors.redAccent
                      : AppColorCode.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Divider(
                color: data.menuCategoryId == ctr.mainCatId
                    ? Colors.redAccent
                    : AppColorCode.whiteshadow,
              )
            ],
          ),
        );
      }),
    );
  }

  Widget appBar({String? label}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              proCtr.controlMenu();
            },
            child: Container(
              child: const Center(
                child: Icon(
                  Icons.format_align_justify_rounded,
                  color: Colors.grey,
                  size: 40,
                ),
              ),
            ),
          ),
          Badge(
            position: BadgePosition.topEnd(top: 0, end: 3),
            animationDuration: Duration(milliseconds: 300),
            animationType: BadgeAnimationType.slide,
            badgeContent: Center(
              child: Text(
                proCtr.cartList.length.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
            child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.grey,
                  size: 40,
                ),
                onPressed: () {
                  proCtr.totalZero(0.0);
                  proCtr.itemZero(0);
                  Get.to(CartItemScreen());
                }),
          ),
        ],
      ),
    );
  }
}
