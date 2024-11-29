import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_pattern/bloc/login_bloc.dart';
import 'package:flutter_bloc_pattern/utils/validations.dart';

class EmailTextFeild extends StatelessWidget {
  final FocusNode emailFocusNode;
  const EmailTextFeild({super.key, required this.emailFocusNode});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginStates>(
      buildWhen: (previous, current) => current.email != previous.email,
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.emailAddress,
          focusNode: emailFocusNode,
          decoration: const InputDecoration(
              hintText: 'Email', border: OutlineInputBorder()),
          onChanged: (value) {
            context.read<LoginBloc>().add(EmailChangeEvent(email: value));
          },
          validator: (value) {
            if (value!.isEmpty) {
              return 'Enter email';
            }
            if (!Validations.emailValidator(value)) {
              return 'Invalid email';
            }
            return null;
          },
          onFieldSubmitted: (value) {},
        );
      },
    );
  }
}
