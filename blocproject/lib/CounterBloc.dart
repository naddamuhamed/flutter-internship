import 'package:bloc/bloc.dart';

enum CounterEvents {increment, decrement}

class CounterBloc extends Bloc<CounterEvents, int>{
  CounterBloc() : super(0);

  void increment() => emit(state +1);

  void decrement() => emit(state - 1);

}