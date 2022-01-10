import 'package:farawlah_app/constents/firebase.dart';
import 'package:farawlah_app/views/screens/all_products_details.dart';
import 'package:farawlah_app/views/screens/auth/main_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();
  late Rx<User?> firebaseUser;

  late Rx<GoogleSignInAccount?> googleSignInAccount;
  RxBool isLoggedIn = false.obs;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  // Rx<UserModel> userModel = userModel().obs;
  TextEditingController phone = TextEditingController();
  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    googleSignInAccount = Rx<GoogleSignInAccount?>(googleSign.currentUser);

    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);

    googleSignInAccount.bindStream(googleSign.onCurrentUserChanged);
    ever(googleSignInAccount, _setInitialScreenGoogle);
  }

  _setInitialScreenGoogle(GoogleSignInAccount? googleSignInAccount) {
    if (FirebaseAuth.instance.currentUser?.uid == null) {
      // if the user is not found then the user is navigated to the Register Screen
      Get.offAll(() => const AuthScreen());
    } else {
      // if the user exists and logged in the the user is navigated to the Home Screen
      Get.offAll(() => const AllProductsScreen());
    }
  }

  _setInitialScreen(User? user) {
    if (FirebaseAuth.instance.currentUser?.uid == null) {
      Get.offAll(() => const AuthScreen());
    } else {
      //   userModel.bindStream(listenToUser());
      Get.offAll(() => const AllProductsScreen());
    }
  }

  void signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        await auth
            .signInWithCredential(credential)
            // ignore: invalid_return_type_for_catch_error
            .catchError((onErr) => print(onErr));
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signIn() async {
    try {
      //    showLoading();
      await auth
          .signInWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        _clearControllers();
      });
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Sign In Failed", "Try again");
    }
  }

  void signUp() async {
    // showLoading();
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        //   _addUserToFirestore(_userId);
        //  _addUserIemToFirestore(_userId);
        _clearControllers();
      });
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Sign In Failed", "Try again");
    }
  }

  void signOut() async {
    await auth.signOut();
  }

  // _addUserToFirestore(String userId) {
  //   firebaseFirestore.collection(usersCollection).doc(userId).set({
  //     "name": name.text.trim(),
  //     "id": userId,
  //     "email": email.text.trim(),
  //     "cart": [],
  //   });
  // }

  // _addUserIemToFirestore(String userId) {
  //   firebaseFirestore
  //       .collection(usersItemsCollection)
  //       .doc(userId)
  //       .set({"subCatid": userId, "items": []});
  // }

  _clearControllers() {
    name.clear();
    email.clear();
    password.clear();
  }

  // updateUserData(Map<String, dynamic> data) {
  //   logger.i("UPDATED");
  //   firebaseFirestore
  //       .collection(usersCollection)
  //       .doc(firebaseUser.value!.uid)
  //       .update(data);
  // }

//   addPostData(Map<String, dynamic> data, String id) {
//     logger.i("UPDATED");
//     firebaseFirestore.collection(postCatCollection).doc(id).set(data);
//   }

//   updateUserMainCatWithId(Map<String, dynamic> data, String id) {
//     logger.i("UPDATED");
//     firebaseFirestore
//         .collection(usersCollection)
//         .doc(firebaseUser.value!.uid)
//         .collection(usersmainCatCollection)
//         .doc(id)
//         .set(data);
//   }

//   updateUserItemWithId(Map<String, dynamic> data, String id, String itemId) {
//     logger.i("UPDATED");
//     firebaseFirestore
//         .collection(usersCollection)
//         .doc(firebaseUser.value!.uid)
//         .collection(usersmainCatCollection)
//         .doc(id)
//         .collection(usersItemsCollection)
//         .doc(itemId)
//         .set(data);
//   }

//   updateUserDataSet(Map<String, dynamic> data, String id) {
//     logger.i("UPDATED");
//     firebaseFirestore
//         .collection(usersCollection)
//         .doc(firebaseUser.value!.uid)
//         .collection(usersmainCatCollection)
//         .doc(id)
//         .set(data);
//   }

//   Stream<UserModel> listenToUser() => firebaseFirestore
//       .collection(usersCollection)
//       .doc(firebaseUser.value!.uid)
//       .snapshots()
//       .map((snapshot) => UserModel.fromSnapshot(snapshot));
}
