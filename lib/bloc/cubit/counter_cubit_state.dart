part of 'counter_cubit_bloc.dart';

class CounterCubitState extends Equatable {
  final int counter;
  final bool? isIncremented;
  const CounterCubitState({required this.counter, this.isIncremented});

  @override
  // TODO: implement props
  List<Object?> get props => [counter, isIncremented];
}
