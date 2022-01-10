import 'package:farawlah_app/controller/product_controller.dart';
import 'package:farawlah_app/model/core/all_data_model.dart';
import 'package:farawlah_app/utils/AppColorCode.dart';
import 'package:farawlah_app/utils/AppFontOswald.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ProductWidget extends StatefulWidget {
  final CategoryDishes data;
  final int? index;
  const ProductWidget({Key? key, this.index, required this.data})
      : super(key: key);

  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  ProductCtr proCtr = Get.put(ProductCtr());
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        const Positioned(
          child: Divider(
            color: Colors.grey,
          ),
        ),
        Positioned(
          left: 2,
          right: 310,
          bottom: 90,
          top: 10,
          child: Container(
            height: 20,
            width: 10,
            decoration: BoxDecoration(
                color: AppColorCode.whiteshadow,
                borderRadius: BorderRadius.circular(1),
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                )),
            child: Padding(
              padding: EdgeInsets.all(1.0),
              child: Center(
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: widget.index!.isEven
                        ? AppColorCode.greenColor
                        : Colors.red,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 260,
          right: 10,
          bottom: 30,
          child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                // image: DecorationImage(
                //     image: NetworkImage(widget.data.dishImage!)),
                borderRadius: BorderRadius.circular(1),
              )),
        ),
        Positioned(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 60.w,
                      height: 3.h,
                      child: Text(
                        widget.data.dishName ?? '',
                        style: AppFontMain(
                          color: AppColorCode.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      width: 60.w,
                      height: 3.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                widget.data.dishCurrency!,
                                style: AppFontMain(
                                  color: AppColorCode.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                widget.data.dishPrice.toString(),
                                style: AppFontMain(
                                  color: AppColorCode.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            widget.data.dishCalories.toString() + "Calories",
                            style: AppFontMain(
                              color: AppColorCode.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 50.w,
                      height: 7.h,
                      child: Text(
                        widget.data.dishDescription!,
                        style: AppFontMain(
                          color: AppColorCode.secondaryText,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColorCode.greenColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  if (widget.data.counter! <= 0) {
                                    Get.snackbar("Please Add", "  your cart");
                                  } else {
                                    proCtr.cartUpdateItem(
                                        widget.data, widget.data.counter! - 1);
                                  }
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  widget.data.counter.toString(),
                                  style: AppFontMain(
                                    color: AppColorCode.headerColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  proCtr.addCartList(widget.data);
                                  proCtr.cartUpdateItem(
                                      widget.data, widget.data.counter! + 1);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.add_outlined,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
