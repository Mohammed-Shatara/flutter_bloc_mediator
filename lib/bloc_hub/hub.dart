
import '../communication_types/base_communication.dart';
import 'bloc_member.dart';
import 'member.dart';

abstract class BlocHub {
  List<Member> getMembers();

  void sendToByName(
        String senderName, CommunicationType data, String receiverName);

  void registerByName(BlocMember member, String name);

  void sendToAll(String senderName, CommunicationType data);
}
