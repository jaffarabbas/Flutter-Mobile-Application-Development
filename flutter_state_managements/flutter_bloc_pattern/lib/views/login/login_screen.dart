import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_pattern/bloc/login_bloc.dart';
import 'package:flutter_bloc_pattern/main.dart';
import 'package:flutter_bloc_pattern/repository/auth/login_repository.dart';
import 'package:flutter_bloc_pattern/views/login/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc loginBloc;
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    loginBloc = LoginBloc(loginRepository: getIt());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: BlocProvider(
        create: (_) => loginBloc,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                EmailTextFeild(emailFocusNode: emailFocusNode),
                const SizedBox(
                  height: 20,
                ),
                PasswrodTextFeild(passwordFocusNode: passwordFocusNode),
                const SizedBox(
                  height: 20,
                ),
                LoginButton(formKey: _formKey)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
