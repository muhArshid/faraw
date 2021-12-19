import 'package:farawlah_app/utils/AppColorCode.dart';
import 'package:farawlah_app/utils/AppFontOswald.dart';
import 'package:farawlah_app/utils/asset_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

errorDialog(String mssg) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'OOPS..',
              style: AppFontMain(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                mssg,
                style: AppFontMain(fontSize: 14, color: AppColorCode.textDim),
                // overflow: TextOverflow.ellipsis,
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () => Get.back(),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColorCode.brandColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'OKAY',
                      style: AppFontMain(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
