import 'dart:math';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
                      onPressed: () async {
                        await Supabase.instance.client.auth.signUp(
                            emailControler.text, passwordControler.text);
                      },
                      child: const Text("Sign Up"),
                    ),
                    OutlinedButton(
                      onPressed: () async {
                        await Supabase.instance.client.auth
                            .signIn(
                              email: emailControler.text,
                              password: passwordControler.text,
                            )
                            .then((value) => print(value.data?.user?.email));
                      },
                      child: const Text("Sign In"),
                    ),
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
