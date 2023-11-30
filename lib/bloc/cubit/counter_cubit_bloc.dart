import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_communicatiom/bloc/cubit/internet_cubit.dart';
import 'package:equatable/equatable.dart';

part 'counter_cubit_state.dart';

class CounterCubitBloc extends Cubit<CounterCubitState> {
  StreamSubscription? internetStreamSubscription;
  final InternetCubit? internetCubit;

  CounterCubitBloc({this.internetCubit})
      : super(const CounterCubitState(counter: 0));

  ///When the internet is connected, The count should increment
  void increment() =>
      emit(CounterCubitState(counter: state.counter + 1, isIncremented: true));

  ///When the internet is disconnected, the counter should decrement
  void decrement() =>
      emit(CounterCubitState(counter: state.counter - 1, isIncremented: false));
}
