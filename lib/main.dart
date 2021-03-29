import 'package:flutter/material.dart';

import 'package:jptapp/features/jptapp/presentation/pages/details_page.dart';
import 'package:jptapp/features/jptapp/presentation/pages/items_page.dart';
import 'package:jptapp/features/jptapp/presentation/pages/settings_page.dart';
import 'features/jptapp/presentation/pages/login_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JPT APP',
      home: LoginPage(),
      routes: {
        '/details': (context) => DetailsPage(),
        '/settings': (context) => SettingsPage(),
        '/items': (context) => ItemsPage()
      },
    );
  }
}
