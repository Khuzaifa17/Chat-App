import 'package:flutter/material.dart';

import '../../Pages/Login_page.dart';
import '../../Pages/Register_page.dart';

class Loginorregister extends StatefulWidget {
  const Loginorregister({super.key});

  @override
  State<Loginorregister> createState() => _LoginorregisterState();
}

class _LoginorregisterState extends State<Loginorregister> {
  bool showloginpage = true;
  void tooglepage() {
    setState(() {
      showloginpage = !showloginpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showloginpage) {
      return LoginPage(
        ontap: tooglepage,
      );
    } else {
      return RegisterPage(
        ontap: tooglepage,
      );
    }
  }
}
