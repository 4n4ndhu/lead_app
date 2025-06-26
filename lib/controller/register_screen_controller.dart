import 'package:flutter/material.dart';

class RegisterScreenController with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  TextEditingController regEmailController = TextEditingController();
  TextEditingController regPassController = TextEditingController();
}
