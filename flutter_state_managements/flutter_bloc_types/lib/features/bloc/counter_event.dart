part of 'counter_bloc.dart';

@immutable
sealed class CounterEvent {}

class CounterIncrementEvent extends CounterEvent {}

class CounterSnackBarEvent extends CounterEvent {}

class CounterIncreementAndSnackBarEvent extends CounterEvent {}
