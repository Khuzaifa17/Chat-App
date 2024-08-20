import 'package:flutter/material.dart';
import '../Services/Auth/auth_services.dart';
import '../Components/Button.dart';
import '../Components/TextField.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController pwdcontroller = TextEditingController();
  final void Function()? ontap;
  LoginPage({super.key, required this.ontap});

  void login(BuildContext context) async {
    final authservice = AuthServices();
    try {
      await authservice.signIn(emailcontroller.text, pwdcontroller.text);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
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
          MyButton(
            text: "Login",
            ontap: () => login(context),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Not a member? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  )),
              GestureDetector(
                  onTap: ontap,
                  child: Text(
                    "Registered Now",
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
