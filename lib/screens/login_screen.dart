import 'package:flutter/material.dart';
import 'package:num_search/services/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthService auth = AuthService();

  @override
  void initState() {
    super.initState();
    // auth.getUser.then((user) {
    //   print(user);
    //   if (user != null) {
    //     Navigator.pushNamedAndRemoveUntil(context, '/profile', (_) => false);
    //   }
    //   ;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                await auth.googleSignIn();
                auth.getUser.then((user) => {
                      if (user != null)
                        {Navigator.pushReplacementNamed(context, '/dashboard')}
                    });
              },
              child: Text('Login with google'),
            ),
          )
        ],
      ),
    );
  }
}
