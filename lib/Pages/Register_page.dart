import 'package:c/Services/Auth/auth_services.dart';
import 'package:flutter/material.dart';

import '../Components/Button.dart';
import '../Components/TextField.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController pwdcontroller = TextEditingController();
  final TextEditingController confirmpwdcontroller = TextEditingController();

  final void Function()? ontap;
  RegisterPage({super.key, required this.ontap});

  void Register(BuildContext context) {
    final auth = AuthServices();
    if (pwdcontroller.text == confirmpwdcontroller.text) {
      try {
        auth.signup(
            emailcontroller.text, pwdcontroller.text, namecontroller.text);
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Password Do'nt matched"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.message,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(
            height: 50,
          ),
          MyTextfield(
            controller: namecontroller,
            hintText: "Name",
            obscureText: false,
          ),
          SizedBox(
            height: 10,
          ),
          MyTextfield(
            controller: emailcontroller,
            hintText: "Email",
            obscureText: false,
          ),
          SizedBox(
            height: 10,
          ),
          MyTextfield(
            controller: pwdcontroller,
            hintText: "Password",
            obscureText: true,
          ),
          SizedBox(
            height: 10,
          ),
          MyTextfield(
            controller: confirmpwdcontroller,
            hintText: "ConfirmPassword",
            obscureText: true,
          ),
          SizedBox(
            height: 10,
          ),
          MyButton(
            text: "Register",
            ontap: () => Register(context),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an account? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  )),
              GestureDetector(
                  onTap: ontap,
                  child: Text(
                    "login now",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
