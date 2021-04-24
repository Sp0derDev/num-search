import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:num_search/screens/dashboard_screen.dart';
import 'package:num_search/screens/login_screen.dart';
import 'package:num_search/screens/new_entry_screen.dart';
import 'package:num_search/screens/profile_screen.dart';
import 'package:num_search/screens/search_page.dart';
import 'package:num_search/services/auth.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<SiteUser>.value(value: AuthService().user),
      ],
      child: MaterialApp(
        title: 'NumSearch',
        navigatorObservers: [
          FirebaseAnalyticsObserver(
            analytics: (FirebaseAnalytics()),
          ),
        ],
        routes: {
          '/': (context) => DashboardScreen(),
          '/profile': (context) => ProfileScreen(),
          '/dashboard': (context) => DashboardScreen(),
          '/new_entry': (context) => NewEntryScreen(),
          '/search': (context) => SearchScreen(),
        },
        theme:
            ThemeData.light().copyWith(primaryColor: Colors.deepOrangeAccent),
      ),
    );
  }
}
