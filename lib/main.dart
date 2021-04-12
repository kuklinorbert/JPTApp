import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:jptapp/features/jptapp/presentation/pages/details_page.dart';
import 'package:jptapp/features/jptapp/presentation/pages/html_page.dart';
import 'package:jptapp/features/jptapp/presentation/pages/items_page.dart';
import 'package:jptapp/features/jptapp/presentation/pages/pdf_page.dart';
import 'package:jptapp/features/jptapp/presentation/pages/qr_scan_page.dart';
import 'package:jptapp/features/jptapp/presentation/pages/settings_page.dart';
import 'package:jptapp/ui/theme_setup.dart';
import 'package:stacked_themes/stacked_themes.dart';
import 'features/jptapp/presentation/pages/login_page.dart';
import 'injection_container.dart' as di;
import 'package:firebase_core/firebase_core.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeManager.initialise();
  await FlutterDownloader.initialize(debug: false);
  await Firebase.initializeApp();
  await di.init();

  runApp(EasyLocalization(
      child: MyApp(),
      supportedLocales: [Locale('en'), Locale('hu')],
      fallbackLocale: Locale('en'),
      path: 'assets/translations'));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
        themes: getThemes(),
        defaultThemeMode: ThemeMode.light,
        builder: (context, theme1, theme2, themeMode) => MaterialApp(
              theme: theme1,
              darkTheme: theme2,
              themeMode: themeMode,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              title: 'JPT App',
              home: LoginPage(),
              routes: {
                '/login': (context) => LoginPage(),
                '/details': (context) => DetailsPage(),
                '/settings': (context) => SettingsPage(),
                '/items': (context) => ItemsPage(),
                '/pdf': (context) => PdfViewPage(),
                '/html': (context) => HtmlViewPage(),
                '/qr-scan': (context) => QrScanPage(),
              },
            ));
  }
}
