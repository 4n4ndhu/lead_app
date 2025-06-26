import 'package:flutter/material.dart';
import 'package:lead_app/controller/login_screen_controller.dart';
import 'package:lead_app/view/bottom_navigationbar.dart';
import 'package:lead_app/view/lead_list_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //create a  provider instant to acces varibales and functions which is inside the provider class
    final provider = context.watch<LoginScreenController>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Login screen"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: provider.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: provider.loginEmailController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                  ),
                  validator: (value) {
                    String pattern =
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                    if (value != null && RegExp(pattern).hasMatch(value)) {
                      return null;
                    } else {
                      return "Enter a valid email";
                    }
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: provider.loginPassController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                  ),
                  validator: (value) {
                    if (value != null && value.length < 6) {
                      return "Password must contain atleast 6 characters";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                if (provider.errorMessage != null)
                  Text(provider.errorMessage!,
                      style: TextStyle(color: Colors.red)),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                    onPressed: provider.isLoading
                        ? null
                        : () async {
                            final success = await provider.login(context);
                            if (success) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BottomNavScreen(),
                                  ));

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Login Successfull'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Login Unsuccessfull'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                    child: provider.isLoading
                        ? CircularProgressIndicator()
                        : Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
