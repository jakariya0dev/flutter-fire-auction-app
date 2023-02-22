import 'package:auction_app/pages/home_page.dart';
import 'package:auction_app/users.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../const.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: Center(
            child: InkWell(
              onTap: () async {
                try {
                  if (GoogleSignIn().currentUser != null) {
                  }
                  else {
                    await GoogleSignIn().signIn().then((value) {
                      UserData.userName = value?.displayName;
                      UserData.userEmail = value?.email;

                    });
                  }
                } catch (E) {
                  // print(E.toString());
                }

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
              child: Card(
                elevation: 3,
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.network(kLogo, fit: BoxFit.cover),
                      const SizedBox(width: 5.0),
                      const Text('Sign-in with Google')
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
