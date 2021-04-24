import 'package:flutter/material.dart';
import 'package:num_search/components/loader.dart';
import 'package:num_search/models/user.dart';
import 'package:num_search/services/auth.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AuthService auth = AuthService();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SiteUser user = Provider.of<SiteUser>(context);
    print(user);
    if (user == null) {
      return LoadingScreen();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(user.username + '\'s Profile Page'),
        ),
      );
    }
  }
}
