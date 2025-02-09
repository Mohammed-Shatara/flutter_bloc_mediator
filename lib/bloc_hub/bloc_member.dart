import '../communication_types/base_communication.dart';
import 'hub.dart';

mixin BlocMember {
  late BlocHub blocHub;
  late String name;

  void receive(String from, CommunicationType data);

  void sendTo(CommunicationType data, String receiverName) {
    blocHub.sendToByName(name, data, receiverName);
  }

  void sendToAll(CommunicationType data) {
    blocHub.sendToAll(name, data);
  }
}
