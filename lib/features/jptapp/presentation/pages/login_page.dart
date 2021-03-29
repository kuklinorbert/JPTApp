import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jptapp/features/jptapp/presentation/bloc/item_bloc.dart';
import 'package:jptapp/features/jptapp/presentation/bloc/login_bloc.dart';
import 'package:jptapp/features/jptapp/presentation/dto/login_dto.dart';

import '../../../../injection_container.dart';
import 'items_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String inputLogin;
  String inputPassword;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: _buildBody(),
      ),
    );
  }

  _buildBody() {
    return BlocListener<LoginBloc, LoginState>(
      cubit: sl<LoginBloc>(),
      listener: (context, state) {
        if (state is ErrorLoggedState) {
          final snackBar = SnackBar(content: Text('Invalid credentials...'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state is LoggedState) {
          Navigator.of(context).pushReplacementNamed('/items');
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        cubit: sl<LoginBloc>(),
        builder: (BuildContext context, state) {
          if (state is InitialLoginState) {
            return _buildForm();
          } else if (state is CheckingLoginState) {
            return CircularProgressIndicator();
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
                inputLogin = value;
              },
              onSaved: (String value) {
                inputLogin = value;
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
              color: Colors.black12,
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  final loginDTO = LoginDTO(
                    username: inputLogin,
                    password: inputPassword,
                  );
                  sl<LoginBloc>().add(CheckLoginEvent(login: loginDTO));
                }
              },
              child: Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}
