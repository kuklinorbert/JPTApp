import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:jptapp/features/jptapp/presentation/pages/details_page.dart';
import 'package:jptapp/features/jptapp/presentation/pages/items_page.dart';
import 'package:jptapp/features/jptapp/presentation/pages/settings_page.dart';
import 'package:jptapp/features/jptapp/presentation/pages/splash_page.dart';
import 'features/jptapp/presentation/pages/login_page.dart';
import 'injection_container.dart' as di;
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  print(FirebaseAuth.instance.currentUser);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JPT APP',
      home: LoginPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/details': (context) => DetailsPage(),
        '/settings': (context) => SettingsPage(),
        '/items': (context) => ItemsPage()
      },
    );
  }
}
