library;

import '../communication_types/base_communication.dart';
import 'bloc_member.dart';
import 'hub.dart';
import 'member.dart';

class ConcreteHub extends BlocHub {
  final Map _blocMembersMap = <String, BlocMember>{};

  @override
  List<Member> getMembers() =>
      _blocMembersMap.entries.map((entry) => entry.value).toList()
          as List<Member>;

  @override
  void sendToAll(String senderName, CommunicationType data) {
    final filteredMembers = _blocMembersMap.entries
        .map((entry) => Member(entry.key, entry.value))
        .toList()
        .where((element) => element.name != senderName);

    for (final member in filteredMembers) {
      member.child.receive(senderName, data);
    }
  }

  @override
  void sendToByName(
      String senderName, CommunicationType data, String receiverName) {
    if (_blocMembersMap.containsKey(receiverName)) {
      _blocMembersMap[receiverName].receive(senderName, data);
    }
    return;
  }

  @override
  void registerByName(BlocMember member, String name) {
    member.blocHub = this;
    member.name = name;

    _blocMembersMap[name] = member;
  }
}
