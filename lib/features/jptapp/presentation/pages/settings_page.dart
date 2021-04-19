import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jptapp/features/jptapp/presentation/bloc/auth/auth_bloc.dart';
import 'package:jptapp/features/jptapp/presentation/widgets/message_display.dart';
import 'package:jptapp/features/jptapp/presentation/widgets/snackbar_show.dart';
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
          return MessageDisplay(message: state.message);
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
                title: Text("set_theme".tr(),
                    style: Theme.of(context).textTheme.bodyText2),
                onTap: () {
                  if (selectedTheme > 2) {
                    selectedTheme = 0;
                  }
                  getThemeManager(context).selectThemeAtIndex(selectedTheme);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(buildSnackBar(context, 'change_th'.tr()));
                  selectedTheme++;
                }),
            ListTile(
                title: Text(
                  "set_loc".tr(),
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                onTap: () {
                  if (EasyLocalization.of(context).locale == Locale('hu')) {
                    EasyLocalization.of(context).locale = Locale('en');
                    ScaffoldMessenger.of(context).showSnackBar(
                        buildSnackBar(context, 'change_loc'.tr()));
                  } else {
                    EasyLocalization.of(context).locale = Locale('hu');
                    ScaffoldMessenger.of(context).showSnackBar(
                        buildSnackBar(context, 'change_loc'.tr()));
                  }
                }),
            ListTile(
                title: Text('logout'.tr(),
                    style: Theme.of(context).textTheme.bodyText2),
                onTap: () {
                  authBloc.add(AuthLogoutEvent());
                })
          ],
        ),
      ),
    );
  }
}
