import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial()) {
    on<CounterIncrementEvent>(counterIncrementEvent);
    on<CounterSnackBarEvent>(counterSnackBarEvent);
    on<CounterIncreementAndSnackBarEvent>(counterIncreementAndSnackBarEvent);
  }

  int value = 0;

  FutureOr<void> counterIncrementEvent(
      CounterIncrementEvent event, Emitter<CounterState> emit) {
    value = value + 1;
    emit(CounterIncrementState(val: value));
  }

  FutureOr<void> counterSnackBarEvent(
      CounterSnackBarEvent event, Emitter<CounterState> emit) {
    emit(CounterShowSnackBarSateActionState(val: 0));
  }

  FutureOr<void> counterIncreementAndSnackBarEvent(
      CounterIncreementAndSnackBarEvent event, Emitter<CounterState> emit) {
    value = value + 1;
    emit(CounterIncrementState(val: value));
    emit(CounterShowSnackBarSateActionState(val: value));
  }
}
