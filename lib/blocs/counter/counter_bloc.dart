import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState.initial()) {
    on<IncrementCounterEvent>((event, emit) {
      emit(state.copyWith(counter: state.counter + 1));
      // TODO: implement event handler
    });

    /**
     * importent
     * if we have more then one event we have to handle this event like below
     */

    on<DecrementCounterEvent>(_decrementCounter);
  }

  /**
   * this void function below is for the second event for our program
   */

  void _decrementCounter(
    DecrementCounterEvent event,
    Emitter<CounterState> emit,
  ) {
    emit(state.copyWith(counter: state.counter - 1));
  }
}
