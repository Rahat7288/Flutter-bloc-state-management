// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'counter_cubit.dart';

class CounterState {
  final int counter;

  CounterState(this.counter);

  factory CounterState.initial() {
    return CounterState(0);
  }

  @override
  List<Object> get props => [counter];

  @override
  String toString() => 'counterState(counter: &counter)';

  CounterState copyWith({
    int? counter,
  }) {
    return CounterState(
      counter ?? this.counter,
    );
  }
}
