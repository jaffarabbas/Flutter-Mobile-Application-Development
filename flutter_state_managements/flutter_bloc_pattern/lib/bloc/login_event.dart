part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class EmailChangeEvent extends LoginEvent {
  const EmailChangeEvent({required this.email});
  final String email;
  @override
  List<Object> get props => [email];
}

class EmailUnfocusedEvent extends LoginEvent {}

class PasswordChangeEvent extends LoginEvent {
  const PasswordChangeEvent({required this.password});
  final String password;
  @override
  List<Object> get props => [password];
}

class PasswordUnfocusedEvent extends LoginEvent {}

class LoginApiHitEvent extends LoginEvent {}
