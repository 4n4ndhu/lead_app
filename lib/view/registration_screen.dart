// import 'package:flutter/material.dart';
// import 'package:lead_app/controller/register_screen_controller.dart';
// import 'package:lead_app/view/lead_list_screen.dart';
// import 'package:lead_app/view/login_screen.dart';
// import 'package:provider/provider.dart';

// class RegistrationScreen extends StatelessWidget {
//   const RegistrationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<RegisterScreenController>();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Reg screen"),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Form(
//             key: provider.formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "CREATE ACCOUNT!",
//                   style: TextStyle(color: Colors.blue, fontSize: 24),
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 TextFormField(
//                   controller: provider.regEmailController,
//                   decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black)),
//                     focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black)),
//                     errorBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.red)),
//                   ),
//                   validator: (value) {
//                     String pattern =
//                         r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
//                     if (value != null && RegExp(pattern).hasMatch(value)) {
//                       return null;
//                     } else {
//                       return "Enter a valid email";
//                     }
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 TextFormField(
//                   controller: provider.regPassController,
//                   decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black)),
//                     focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black)),
//                     errorBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.red)),
//                   ),
//                   validator: (value) {
//                     if (value != null && value.length < 6) {
//                       return "Password must contain atleast 6 characters";
//                     } else {
//                       return null;
//                     }
//                   },
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//                         style: ButtonStyle(
//                             backgroundColor:
//                                 WidgetStatePropertyAll(Colors.blue)),
//                         onPressed: () {
//                           if (provider.formKey.currentState!.validate()) {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => LeadListScreen(),
//                                 ));
//                           }
//                           ;
//                         },
//                         child: Text(
//                           "Register",
//                           style: TextStyle(
//                               color: Colors.black, fontWeight: FontWeight.bold),
//                         ))),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text("Already have an account?"),
//                     TextButton(
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => LoginScreen(),
//                               ));
//                         },
//                         child: Text(
//                           "Login",
//                           style: TextStyle(color: Colors.blue),
//                         ))
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
