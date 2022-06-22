import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailControler = TextEditingController();
    final passwordControler = TextEditingController();
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: emailControler,
                  decoration: InputDecoration(hintText: "Email"),
                ),
                TextFormField(
                  controller: passwordControler,
                  decoration: InputDecoration(hintText: "Password"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        print([emailControler.text, passwordControler.text]);
                      },
                      child: Text("Sign In"),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      child: Text("Sign Up"),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
