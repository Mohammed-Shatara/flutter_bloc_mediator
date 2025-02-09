import 'package:flutter_bloc_mediator/communication_types/base_communication.dart';

class CounterComType extends CommunicationType {
  final int count;

  CounterComType({required this.count});
}