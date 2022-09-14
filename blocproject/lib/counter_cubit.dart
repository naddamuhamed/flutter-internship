import 'dart:convert';

import 'package:bloc/bloc.dart';
// import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit(int x) : super(CounterState(counterValue: x));
  // CounterCubit() : super(CounterState(counterValue: x));

  void increment() => emit(
      CounterState(counterValue: state.counterValue + 1));

  void decrement() => emit(CounterState(
      counterValue: state.counterValue - 1));

  @override
  CounterState fromJson(Map<String, dynamic> json) {
    return CounterState.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson(CounterState state) {
    // addError(Exception("Couldn't write to storage!"), StackTrace.current);
    return state.toMap();
  }
}