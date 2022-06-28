import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qentah_app/models/permission.dart';
import 'package:qentah_app/models/user.dart' as model;
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
                    ElevatedButton(
                      onPressed: () async {
                        await Supabase.instance.client.auth.signIn(
                          email: emailControler.text,
                          password: passwordControler.text,
                        );

                        final user = await Supabase.instance.client
                            .from('user')
                            .select('*')
                            .eq('id',
                                Supabase.instance.client.auth.currentUser!.id)
                            .maybeSingle()
                            .execute();
                        print(user.data);
                      },
                      child: const Text("Sign In"),
                    ),
                    OutlinedButton(
                      onPressed: () async {
                        await Supabase.instance.client.auth.signIn(
                          email: 'henryq.dev@outlook.fr',
                          password: '123456',
                        );

                        final user = await Supabase.instance.client
                            .from('user')
                            .select('*')
                            .eq('id',
                                Supabase.instance.client.auth.currentUser!.id)
                            .maybeSingle()
                            .execute();
                        print(user.data);
                      },
                      child: const Text("DEV"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("GraphQL Query"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final user = (await Supabase.instance.client
                                .from('user')
                                .select('*')
                                .eq(
                                    'id',
                                    Supabase
                                        .instance.client.auth.currentUser!.id)
                                .maybeSingle()
                                .execute())
                            .data;

                        final roles = (await Supabase.instance.client
                                .from('role_user')
                                .select('role')
                                .execute())
                            .data as List;

                        final perms = (await Supabase.instance.client
                                .from('permission_user')
                                .select('permission(*)')
                                .execute())
                            .data as List;

                        final permsSet =
                            perms.map((e) => e['permission']).toSet();

                        final roleperms = (await Supabase.instance.client
                                .from('permission_role')
                                .select('permission(*)')
                                .in_('role',
                                    roles.map((e) => e['role']).toList())
                                .execute())
                            .data as List;

                        final rolepermsSet =
                            roleperms.map((e) => e['permission']).toSet();

                        final permsList = permsSet.union(rolepermsSet).toList();
                        final u = model.User.fromJson(user);
                        u.permissions.addAll(
                            permsList.map((e) => Permission.fromJson(e)));

                        model.GlobalUser.instance = u;
                        print(u.toJson());
                      },
                      child: const Text("SQL Query"),
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
