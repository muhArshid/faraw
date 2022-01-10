// ignore_for_file: prefer_function_declarations_over_variables

import 'package:farawlah_app/controller/auth_controller.dart';
import 'package:farawlah_app/utils/AppColorCode.dart';
import 'package:farawlah_app/utils/AppFontOswald.dart';
import 'package:farawlah_app/utils/asset_constants.dart';
import 'package:farawlah_app/views/screens/auth/widgets/phone_widget.dart';
import 'package:farawlah_app/widgets/button_icons_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sms_autofill/sms_autofill.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  UserController authController = Get.find();

  ///
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SmsAutoFill smsAutoFill = SmsAutoFill();
  String? strVerificationId;
  final globalKey = GlobalKey<ScaffoldState>();
  TextEditingController phoneNumEditingController = TextEditingController();
  TextEditingController smsEditingController = TextEditingController();
  bool ifphone = false;
  bool showVerifyNumberWidget = true;
  bool showVerificationCodeWidget = false;
  bool showSuccessWidget = false;
  getCurrentNumber() async {
    phoneNumEditingController.text = await smsAutoFill.hint ?? '+91';
  }

  ///
  @override
  void initState() {
    ifphone = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: globalKey,
      backgroundColor: AppColorCode.pureWhite,
      body: Stack(
        children: [
          Positioned(
              top: 51,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 50,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: ListView(
                    //  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AssetConstant.firebase),
                      const SizedBox(height: 10),
                      if (!ifphone && !showVerificationCodeWidget)
                        button(
                          icondata: Icon(Icons.phone_outlined),
                          label: 'Phone',
                          height: size.height * 0.07,
                          width: size.width * 0.60,
                          buttonColor: AppColorCode.greenColor,
                          onTap: () {
                            setState(() {
                              ifphone = true;
                              showVerifyNumberWidget = false;
                            });
                            getCurrentNumber();
                          },
                        ),
                      if (ifphone)
                        buildtextForm(
                          controller: phoneNumEditingController,
                          label: 'mobile',
                          keyboardType: TextInputType.phone,
                          validator: (val) {},
                        ),
                      if (ifphone)
                        const SizedBox(
                          height: 20,
                        ),
                      if (ifphone)
                        button(
                            label: 'Verify Number',
                            height: size.height * 0.07,
                            width: size.width * 0.60,
                            buttonColor: AppColorCode.greenColor,
                            onTap: () async {
                              if (phoneNumEditingController.text.length > 10) {
                                await phoneNumberVerification();
                                setState(() {
                                  ifphone = false;
                                  showVerifyNumberWidget = false;
                                  showVerificationCodeWidget = true;
                                });
                              } else {
                                Get.snackbar("Please enter", "mobile number");
                              }
                            }),
                      if (showVerificationCodeWidget)
                        Container(
                          child: buildtextForm(
                            controller: smsEditingController,
                            label: 'OTP',
                            keyboardType: TextInputType.number,
                            validator: (val) {},
                          ),
                        ),
                      TextFormField(
                        controller: smsEditingController,
                        decoration: const InputDecoration(
                            labelText: 'Verification code'),
                      ),
                      if (showVerificationCodeWidget)
                        button(
                            label: 'Sign in',
                            height: size.height * 0.07,
                            width: size.width * 0.60,
                            buttonColor: AppColorCode.greenColor,
                            onTap: () async {
                              signInWithPhoneNumber();
                            }),
                      if (showVerificationCodeWidget)
                        const SizedBox(
                          height: 20,
                        ),
                      if (showSuccessWidget)
                        Text('You are successfully logged in!',
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold)),
                      button(
                        icondata: const Icon(Icons.g_mobiledata),
                        label: 'Google',
                        buttonColor: Colors.blue[200]!,
                        height: size.height * 0.07,
                        width: size.width * 0.60,
                        onTap: () {
                          authController.signInWithGoogle();
                        },
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Future<void> phoneNumberVerification() async {
    PhoneVerificationCompleted phoneVerificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await firebaseAuth.signInWithCredential(phoneAuthCredential);
      displayMessage(
          "Phone number is automatically verified and user signed in: ${firebaseAuth.currentUser!.uid}");
      setState(() {
        showVerifyNumberWidget = false;
        showVerificationCodeWidget = false;
        showSuccessWidget = true;
      });
    };

    PhoneVerificationFailed phoneVerificationFailed =
        (FirebaseAuthException authException) {
      displayMessage(
          'Phone number verification is failed. Code: ${authException.code}. Message: ${authException.message}');
    };

    PhoneCodeSent phoneCodeSent =
        (String verificationId, [int? forceResendingToken]) async {
      displayMessage('Please check your phone for the verification code.');
      strVerificationId = verificationId;
      setState(() {
        showVerifyNumberWidget = false;
        showVerificationCodeWidget = true;
      });
    };

    PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout =
        (String verificationId) {
      //  displayMessage("verification code: " + verificationId);
      strVerificationId = verificationId;
      setState(() {
        showVerifyNumberWidget = false;
        showVerificationCodeWidget = true;
      });
    };

    try {
      await firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumEditingController.text,
          timeout: const Duration(seconds: 5),
          verificationCompleted: phoneVerificationCompleted,
          verificationFailed: phoneVerificationFailed,
          codeSent: phoneCodeSent,
          codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout);
    } catch (e) {
      displayMessage("Failed to Verify Phone Number: ${e}");
    }
  }

  void displayMessage(String message) {
    globalKey.currentState!.showSnackBar(SnackBar(content: Text(message)));
  }

  void signInWithPhoneNumber() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: strVerificationId!,
        smsCode: smsEditingController.text,
      );

      final User? user =
          (await firebaseAuth.signInWithCredential(credential)).user;

      displayMessage("Successfully signed in UID: ${user!.uid}");

      setState(() {
        showVerificationCodeWidget = false;
        showSuccessWidget = true;
      });
    } catch (e) {
      displayMessage("Failed to sign in: " + e.toString());
    }
  }
}
