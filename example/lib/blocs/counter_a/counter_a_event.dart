part of 'counter_a_bloc.dart';

@immutable
abstract class CounterAEvent {}

class IncrementAEvent extends CounterAEvent {}

class IncrementBlocBEvent extends CounterAEvent {
  final int count;

  IncrementBlocBEvent({required this.count});
}
