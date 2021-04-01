import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jptapp/features/jptapp/domain/usecases/check_auth.dart';
import 'package:jptapp/features/jptapp/presentation/bloc/auth_bloc.dart';

import '../../../../injection_container.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String inputEmail;
  String inputPassword;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthBloc authBloc;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    authBloc = sl<AuthBloc>()..add(CheckAuthEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: _buildBody(),
        ),
      ),
    );
  }

  _buildBody() {
    return BlocListener<AuthBloc, AuthState>(
      cubit: authBloc,
      listener: (context, state) {
        if (state is ErrorLoggedState) {
          final snackBar = SnackBar(content: Text(state.message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state is Authenticated) {
          Navigator.of(context).pushReplacementNamed('/items');
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        cubit: sl<AuthBloc>(),
        builder: (BuildContext context, state) {
          if (state is CheckAuthState) {
            return CircularProgressIndicator();
          } else if (state is CheckingLoginState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is Authenticated) {
            return Container();
            //return Center(child: CircularProgressIndicator());
          } else {
            return _buildForm();
          }
        },
      ),
    );
  }

  _buildForm() {
    return Form(
      key: _formKey,
      autovalidate: false,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Placeholder(
              fallbackWidth: 150,
              fallbackHeight: 100,
            ),
            SizedBox(
              height: 30.0,
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter the username',
                labelText: 'Username *',
              ),
              onChanged: (value) {
                inputEmail = value;
              },
              onSaved: (String value) {
                inputEmail = value;
              },
              validator: (String value) {
                return value.isEmpty ? 'Username is mandatory' : null;
              },
            ),
            SizedBox(
              height: 30.0,
            ),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Enter the password',
                labelText: 'Password *',
              ),
              onChanged: (value) {
                inputPassword = value;
              },
              onSaved: (String value) {
                inputPassword = value;
              },
              validator: (String value) {
                return value.isEmpty ? 'Password is mandatory' : null;
              },
            ),
            SizedBox(
              height: 30.0,
            ),
            RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  authBloc.add(AuthLoginEvent(
                      email: inputEmail, password: inputPassword));
                }
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
