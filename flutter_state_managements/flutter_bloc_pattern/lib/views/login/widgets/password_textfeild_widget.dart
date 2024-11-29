import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_pattern/bloc/login_bloc.dart';

class PasswrodTextFeild extends StatelessWidget {
  final FocusNode passwordFocusNode;
  const PasswrodTextFeild({super.key, required this.passwordFocusNode});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginStates>(
      buildWhen: (previous, current) => current.password != previous.password,
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.text,
          focusNode: passwordFocusNode,
          obscureText: true,
          decoration: const InputDecoration(
              hintText: 'Password', border: OutlineInputBorder()),
          onChanged: (value) {
            context.read<LoginBloc>().add(PasswordChangeEvent(password: value));
          },
          validator: (value) {
            if (value!.isEmpty) {
              return 'Enter password';
            }
            if (value.length < 6) {
              return 'Password should be at least 6 characters long';
            }
            return null;
          },
          onFieldSubmitted: (value) {},
        );
      },
    );
  }
}
