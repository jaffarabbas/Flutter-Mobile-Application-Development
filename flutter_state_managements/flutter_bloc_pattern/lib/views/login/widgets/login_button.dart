import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_pattern/bloc/login_bloc.dart';
import 'package:flutter_bloc_pattern/utils/enums.dart';

class LoginButton extends StatelessWidget {
  final formKey;
  const LoginButton({Key? key, required this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginStates>(
      listenWhen: (previous, current) =>
          current.postApiStatus != previous.postApiStatus,
      listener: (context, state) {
        if (state.postApiStatus == PostApiStatus.error) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  state.message.toString(),
                ),
              ),
            );
        }
        if (state.postApiStatus == PostApiStatus.success) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  state.message.toString(),
                ),
              ),
            );
        }
        if (state.postApiStatus == PostApiStatus.loading) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Submitting'),
              ),
            );
        }
      },
      child: BlocBuilder<LoginBloc, LoginStates>(
        buildWhen: (previous, current) =>
            current.postApiStatus != previous.postApiStatus,
        builder: (context, state) {
          return ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                context.read<LoginBloc>().add(LoginApiHitEvent());
              }
            },
            child: state.postApiStatus == PostApiStatus.loading
                ? const CircularProgressIndicator()
                : const Text('Login'),
          );
        },
      ),
    );
  }
}
