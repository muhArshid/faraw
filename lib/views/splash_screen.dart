import 'package:farawlah_app/utils/AppColorCode.dart';
import 'package:farawlah_app/utils/AppFontOswald.dart';
import 'package:farawlah_app/utils/asset_constants.dart';
import 'package:farawlah_app/views/screens/all_products_details.dart';
import 'package:farawlah_app/views/screens/auth/main_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      if (FirebaseAuth.instance.currentUser?.uid == null) {
        Get.offAll(() => const AuthScreen());
      } else {
        Get.offAll(() => const AllProductsScreen());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: AppColorCode.bgColor,
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          color: AppColorCode.greenColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 14),
            Text(
              AssetConstant.appName,
              style: AppFontMain(
                color: AppColorCode.whiteshadow,
                fontSize: 36,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
