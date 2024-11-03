part of 'counter_bloc.dart';

@immutable
sealed class CounterState {}

final class CounterInitial extends CounterState {}

abstract class CounterActionState extends CounterState {}

class CounterShowSnackBarSateActionState extends CounterActionState {
  final int val;

  CounterShowSnackBarSateActionState({required this.val});
}

class CounterIncrementState extends CounterState {
  final int val;

  CounterIncrementState({required this.val});
}
