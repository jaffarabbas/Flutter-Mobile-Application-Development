import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_pattern/repository/auth/login_repository.dart';
import 'package:flutter_bloc_pattern/utils/enums.dart';

part 'login_event.dart';
part 'login_states.dart';

class LoginBloc extends Bloc<LoginEvent, LoginStates> {
  LoginRepository loginRepository;
  LoginBloc({required this.loginRepository}) : super(const LoginStates()) {
    on<EmailChangeEvent>(_onEmailChangeEvent);
    on<PasswordChangeEvent>(_onPasswordChangeEvent);
    on<LoginApiHitEvent>(_loginApiHitEvent);
  }

  FutureOr<void> _onEmailChangeEvent(
      EmailChangeEvent event, Emitter<LoginStates> emit) {
    emit(state.copyWith(email: event.email));
  }

  FutureOr<void> _onPasswordChangeEvent(
      PasswordChangeEvent event, Emitter<LoginStates> emit) {
    emit(state.copyWith(password: event.password));
  }

  FutureOr<void> _loginApiHitEvent(
      LoginApiHitEvent event, Emitter<LoginStates> emit) async {
    Map data = {
      'email': state.email.toString(),
      'password': state.password.toString()
    };
    print(data);
    emit(state.copyWith(postApiStatus: PostApiStatus.loading));
    await loginRepository.loginApi(data).then((value) {
      print(value);
      if (value.error.isNotEmpty) {
        emit(state.copyWith(
            message: value.error.toString(),
            postApiStatus: PostApiStatus.error));
      } else {
        emit(state.copyWith(
            message: 'Login successful', postApiStatus: PostApiStatus.success));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(
          message: error.toString(), postApiStatus: PostApiStatus.error));
    });
  }
}
