import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:num_search/components/constants.dart';
import 'package:num_search/services/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthService auth = AuthService();

  void _loginWithGoogle() async {
    await auth.googleSignIn();
    auth.getUser.then((user) => {
          if (user != null)
            {Navigator.pushReplacementNamed(context, '/dashboard')}
        });
  }

  Future<void> _showDialog(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Service Unavailable'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    auth.getUser.then((user) {
      print(user);
      if (user != null) {
        Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (_) => false);
      }
      ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: kXGradient),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.4,
              margin: EdgeInsets.symmetric(vertical: 50),
              constraints: BoxConstraints(minWidth: 100, maxWidth: 300),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      'Lets Get Started',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.farro(
                          fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        SignInButton(
                          Buttons.Google,
                          text: "Sign in with Google",
                          onPressed: () => _loginWithGoogle(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SignInButton(
                          Buttons.Twitter,
                          text: "Sign in with Twitter",
                          onPressed: () => _showDialog(
                              'Signing in with Twitter is currently not available'),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SignInButton(
                          Buttons.FacebookNew,
                          text: "Sign in with Facebook",
                          onPressed: () => _showDialog(
                              'Signing in with Facebook is currently not available'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
