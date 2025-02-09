import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_mediator/bloc_hub/bloc_member.dart';
import 'package:flutter_bloc_mediator/communication_types/base_communication.dart';
import 'package:meta/meta.dart';

import '../../counter_com_type.dart';

part 'counter_a_event.dart';
part 'counter_a_state.dart';

class CounterABloc extends Bloc<CounterAEvent, CounterAState> with BlocMember{
  CounterABloc() : super(CounterAState()) {
    on<IncrementAEvent>((event, emit) {
      final counterValue = state.count+1;
      emit(state.copyWith(count: counterValue));
      sendTo(CounterComType(count: counterValue), 'CounterBBloc');

    });
    on<IncrementBlocBEvent>((event,emit) {
      emit(state.copyWith(blocBCount: event.count));
    });
  }

  @override
  void receive(String from, CommunicationType data) {
    if(data is CounterComType) {
      add(IncrementBlocBEvent(count: data.count));
    }
  }
}
