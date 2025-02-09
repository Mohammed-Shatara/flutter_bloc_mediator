part of 'counter_b_bloc.dart';

@immutable
class CounterBState {
  final int count;
  final int blocACount;

  const CounterBState({this.count = 0, this.blocACount = 0});

  CounterBState copyWith({int? count, int? blocACount}) {
    return CounterBState(
        count: count ?? this.count, blocACount: blocACount ?? this.blocACount);
  }
}
