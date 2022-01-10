import 'package:farawlah_app/controller/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';

final Future<FirebaseApp> initialization = Firebase.initializeApp();
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseMessaging fcm = FirebaseMessaging.instance;
GoogleSignIn googleSign = GoogleSignIn();
final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();
UserController userController = UserController.instance;
