// import 'package:farawlah_app/constents/firebase.dart';
// import 'package:farawlah_app/widgets/button_icons_widgets.dart';
// import 'package:flutter/cupertino.dart';

// class OTPScreen extends StatefulWidget {
//   OTPScreen({Key? key}) : super(key: key);

//   @override
//   _OTPScreenState createState() => _OTPScreenState();
// }

// class _OTPScreenState extends State<OTPScreen> {
//   final _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//         key: _formKey,
//         child: Column(
//             //padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
//             children: [
//               const SizedBox(
//                 height: 10,
//               ),
//               Container(
//                 child: buildtextForm(
//                   controller: userController.phone,
//                   label: 'mobile',
//                   keyboardType: TextInputType.phone,
//                   maxLines: 5,
//                   minLines: 5,
//                   validator: (val) {
//                     if (val!.isEmpty) {
//                       return 'Enter Description';
//                     }
//                   },
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               )
//             ]));
//   }
// }
