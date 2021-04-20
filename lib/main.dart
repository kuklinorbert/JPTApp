import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jptapp/features/jptapp/domain/usecases/check_permission.dart';
import 'package:jptapp/features/jptapp/domain/usecases/start_download.dart';
import 'package:jptapp/features/jptapp/presentation/bloc/download/download_bloc.dart';

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

import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeManager.initialise();
  await Firebase.initializeApp();
  await di.init();

  runApp(EasyLocalization(
    child: MyApp(),
    supportedLocales: [Locale('en'), Locale('hu')],
    fallbackLocale: Locale('en'),
    path: 'assets/translations',
    preloaderColor: Color.fromRGBO(66, 165, 245, 1),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
        themes: getThemes(),
        defaultThemeMode: ThemeMode.light,
        builder: (context, theme1, theme2, themeMode) => BlocProvider(
              create: (BuildContext context) => DownloadBloc(
                  startDownload: sl<StartDownload>(),
                  checkPermission: sl<CheckPermission>()),
              child: MaterialApp(
                theme: theme1,
                darkTheme: theme2,
                themeMode: themeMode,
                localeResolutionCallback:
                    (Locale locale, Iterable<Locale> supportedLocales) {
                  for (var supportedLocale in supportedLocales) {
                    if (supportedLocale.languageCode == locale.languageCode)
                      return context.locale = supportedLocale;
                  }
                  return context.locale;
                },
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
              ),
            ));
  }
}
