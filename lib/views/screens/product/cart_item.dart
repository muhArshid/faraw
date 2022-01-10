import 'package:farawlah_app/controller/product_controller.dart';
import 'package:farawlah_app/utils/AppColorCode.dart';
import 'package:farawlah_app/utils/AppFontOswald.dart';
import 'package:farawlah_app/views/screens/product/widget/cart_item.dart';
import 'package:farawlah_app/widgets/button_icons_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class CartItemScreen extends StatefulWidget {
  CartItemScreen({Key? key}) : super(key: key);

  @override
  _CartItemScreenState createState() => _CartItemScreenState();
}

class _CartItemScreenState extends State<CartItemScreen> {
  ProductCtr proCtr = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: GetBuilder<ProductCtr>(
                builder: (ct) => Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: appBar(
                            label: 'Order Summary',
                          ),
                        ),
                        Positioned(
                            top: 60,
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: ListView(
                                    physics: const BouncingScrollPhysics(),
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        height: 10.h,
                                        decoration: BoxDecoration(
                                            color: AppColorCode.greenColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                          child: Text(
                                            ct.cartList.length.toString() +
                                                ' Dishes -' +
                                                ct.totalItem.toString() +
                                                ' Item',
                                            style: AppFontMain(
                                              color: AppColorCode.whiteshadow,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ListView.builder(
                                          itemCount: ct.cartList.length,
                                          shrinkWrap: true,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return CartItemWidget(
                                                data: ct.cartList[index],
                                                index: index);
                                          }),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            'Total Amount',
                                            style: AppFontMain(
                                              color: AppColorCode.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Obx(() => Text(
                                                proCtr.totalAmount.toString(),
                                                style: AppFontMain(
                                                  color: AppColorCode.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              )),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 100,
                                      ),
                                    ]))),
                        Positioned(
                          top: 85.h,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColorCode.greenColor,
                                  borderRadius: BorderRadius.circular(35)),
                              child: Center(
                                child: Text(
                                  'Place Order',
                                  style: AppFontMain(
                                    color: AppColorCode.whiteshadow,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))));
  }
}
