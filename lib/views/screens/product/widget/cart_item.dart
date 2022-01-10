import 'package:farawlah_app/controller/product_controller.dart';
import 'package:farawlah_app/model/core/all_data_model.dart';
import 'package:farawlah_app/utils/AppColorCode.dart';
import 'package:farawlah_app/utils/AppFontOswald.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class CartItemWidget extends StatefulWidget {
  final CategoryDishes? data;
  final int? index;
  const CartItemWidget({Key? key, this.data, this.index}) : super(key: key);

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  ProductCtr ctr = Get.put(ProductCtr());
  bool isfirst = true;
  ProductCtr proCtr = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double sum = widget.data!.dishPrice!.toDouble() * widget.data!.counter!;

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (isfirst) {
        proCtr.addAmount(sum.toDouble());
        proCtr.additem(widget.data!.counter!);
      }
      setState(() {
        isfirst = false;
      });
    });
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 20,
                width: 20,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 30.w,
                      height: 7.h,
                      child: Text(
                        widget.data!.dishName!,
                        style: AppFontMain(
                          color: AppColorCode.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "INR  " + widget.data!.dishPrice.toString(),
                        style: AppFontMain(
                          color: AppColorCode.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      widget.data!.dishCalories.toString() + '  calories',
                      style: AppFontMain(
                        color: AppColorCode.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
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
                            if (widget.data!.counter! <= 0) {
                              Get.snackbar("Please Add", "  your cart");
                            } else {
                              proCtr.removeItem(1);
                              proCtr.removeAmount(
                                  widget.data!.dishPrice!.toDouble());
                              proCtr.cartUpdateItem(
                                  widget.data!, widget.data!.counter! - 1);
                              setState(() {});
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
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            widget.data!.counter.toString(),
                            style: AppFontMain(
                              color: AppColorCode.pureWhite,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            proCtr.additem(1);
                            proCtr
                                .addAmount(widget.data!.dishPrice!.toDouble());
                            proCtr.cartUpdateItem(
                                widget.data!, widget.data!.counter! + 1);
                            setState(() {});
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
              Container(
                width: 15.w,
                height: 10.h,
                child: Padding(
                  padding: const EdgeInsets.all(.0),
                  child: Text(
                    'INR ' + sum.toString(),
                    style: AppFontMain(
                      color: AppColorCode.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 0.10,
          color: AppColorCode.grey2,
        )
      ],
    );
  }
}
