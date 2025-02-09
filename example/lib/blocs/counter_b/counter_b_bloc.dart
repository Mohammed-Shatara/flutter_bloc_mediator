import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_mediator/bloc_hub/bloc_member.dart';
import 'package:flutter_bloc_mediator/communication_types/base_communication.dart';
import 'package:meta/meta.dart';

import '../../counter_com_type.dart';

part 'counter_b_event.dart';

part 'counter_b_state.dart';

class CounterBBloc extends Bloc<CounterBEvent, CounterBState> with BlocMember {
  CounterBBloc() : super(CounterBState()) {
    on<IncrementBEvent>((event, emit) {
      final counterValue = state.count + 1;
      emit(state.copyWith(count: counterValue));
      sendTo(CounterComType(count: counterValue), 'CounterABloc');
    });
    on<IncrementBlocAEvent>((event, emit) {
      emit(state.copyWith(blocACount: event.count));
    });
  }

  @override
  void receive(String from, CommunicationType data) {
    if (data is CounterComType) {
      add(IncrementBlocAEvent(count: data.count));
    }
  }
}
