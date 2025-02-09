part of 'counter_b_bloc.dart';

@immutable
abstract class CounterBEvent {}

class IncrementBEvent extends CounterBEvent{

}

class IncrementBlocAEvent extends CounterBEvent{
  final int count;

  IncrementBlocAEvent({required this.count});
}