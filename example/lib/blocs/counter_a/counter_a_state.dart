part of 'counter_a_bloc.dart';

@immutable
class CounterAState {
  final int count;
  final int blocBCount;

  const CounterAState({this.count = 0, this.blocBCount = 0});

  CounterAState copyWith({int? count, int? blocBCount}) {
    return CounterAState(
        count: count ?? this.count, blocBCount: blocBCount ?? this.blocBCount);
  }
}
