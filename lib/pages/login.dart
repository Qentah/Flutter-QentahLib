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
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton(
                      onPressed: () async {
                        await Supabase.instance.client.auth.signIn(
                          email: 'henryq.dev@outlook.fr',
                          password: '123456',
                        );
                      },
                      child: const Text("Admin"),
                    ),
                    OutlinedButton(
                      onPressed: () async {
                        await Supabase.instance.client.auth.signIn(
                          email: 'henryq.public@outlook.fr',
                          password: '123456',
                        );
                      },
                      child: const Text("Normal"),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        print(Supabase.instance.client.auth.currentUser?.email);
                      },
                      child: const Text("Info"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Supabase.instance.client
                            .from("user")
                            .select("*")
                            .execute()
                            .then((value) => print(value.data));
                      },
                      child: const Text("Data"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Supabase.instance.client.from("user").insert({
                          "data":
                              "${Supabase.instance.client.auth.currentUser!.email?.split("@")[0]}"
                        }).execute();
                      },
                      child: const Text("Register"),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        /*
                        Supabase.instance.client
                            .rpc('link_machine', params: {
                              "email": Supabase
                                  .instance.client.auth.currentUser!.email,
                              "id_raspi": "100000008cf47bf1",
                              "passw": "123456",
                            })
                            .execute()
                            .then((value) => print("KEY : ${value.data}"));*/
                      },
                      child: const Text("GET KEY"),
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
