import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jptapp/features/jptapp/presentation/bloc/auth_bloc.dart';
import 'package:jptapp/ui/theme_setup.dart';
import 'package:stacked_themes/stacked_themes.dart';

import '../../../../injection_container.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
    authBloc = sl<AuthBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(child: _buildBody()),
    );
  }

  _buildBody() {
    return BlocListener(
      cubit: authBloc,
      listener: (context, state) {
        if (state is Unauthenticated) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/login', (route) => false);
        }
        if (state is ErrorLoggedState) {
          ///
        }
      },
      child: BlocBuilder(
        cubit: sl<AuthBloc>(),
        builder: (BuildContext context, state) {
          return buildItems();
        },
      ),
    );
  }

  Widget buildItems() {
    return Container(
      child: Card(
        child: Column(
          children: [
            ListTile(
                title: Text('Change theme'),
                onTap: () {
                  if (selectedTheme > 2) {
                    selectedTheme = 0;
                  }
                  getThemeManager(context).selectThemeAtIndex(selectedTheme);

                  print(selectedTheme);
                  selectedTheme++;
                }),
            ListTile(
                title: Text('Change locale'),
                onTap: () {
                  if (EasyLocalization.of(context).locale == Locale('hu')) {
                    EasyLocalization.of(context).locale = Locale('en');
                  } else {
                    EasyLocalization.of(context).locale = Locale('hu');
                  }
                }),
            ListTile(
                title: Text('Logout'),
                onTap: () {
                  authBloc.add(AuthLogoutEvent());
                })
          ],
        ),
      ),
    );
  }
}
