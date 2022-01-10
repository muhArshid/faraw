import 'package:farawlah_app/constents/firebase.dart';
import 'package:farawlah_app/utils/AppColorCode.dart';
import 'package:farawlah_app/utils/AppFontOswald.dart';
import 'package:farawlah_app/utils/asset_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

Widget drawerCard(
    {required String label, required IconData icon, Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: AppColorCode.grey2,
                size: 30,
              ),
              SizedBox(width: 20),
              Text(
                label,
                style: AppFontMain(
                  color: AppColorCode.grey2,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
        ],
      ),
    ),
  );
}

// Widget nullDrower(BuildContext context) {

Widget drawer(BuildContext context) {
  return Drawer(
    child: ListView(
      children: [
        Container(
          decoration: BoxDecoration(color: AppColorCode.greenColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              if (userController.googleSignInAccount.value != null)
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 35,
                  backgroundImage: NetworkImage(
                      userController.googleSignInAccount.value!.photoUrl!),
                  // backgroundImage: proCtr.imgePath != null
                  //     ? NetworkImage(
                  //         HttpConstants.imageUrl + proCtr.imgePath!.data!)
                  //     : AssetImage(AssetConstant.demy1) as ImageProvider,
                ),
              SizedBox(height: 10),
              if (userController.googleSignInAccount.value != null)
                Text(
                  userController.googleSignInAccount.value!.displayName!,
                  style: AppFontMain(
                    color: AppColorCode.primaryText,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              SizedBox(height: 10),
              Text(
                'ID :420',
                style: AppFontMain(
                  color: AppColorCode.primaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
        SizedBox(height: 20),
        drawerCard(
            label: 'Log Out',
            icon: Icons.logout_outlined,
            onTap: () async {
              userController.signOut();
              //   await _callNuedmber(appCt.tcData!.helpCenter!);
            }),
      ],
    ),
  );
}
