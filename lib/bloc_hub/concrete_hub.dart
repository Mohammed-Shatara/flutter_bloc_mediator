import 'package:flutter/foundation.dart';

import '../communication_types/base_communication.dart';
import 'bloc_member.dart';
import 'hub.dart';
import 'member.dart';

/// A concrete implementation of [BlocHub] that manages BLoC communication.
///
/// `ConcreteHub` acts as a mediator that allows BLoCs to send and receive messages
/// without direct dependencies on each other. It registers BLoCs using unique names
/// and facilitates message delegation between them.
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

  @override
  void removeByName(String name) {
    _blocMembersMap.remove(name);
  }

  @override
  void clearMembers() {
    _blocMembersMap.clear();
  }

  @override
  bool get isEmpty => _blocMembersMap.isEmpty;

  @override
  bool hasMember(String name) {
    return _blocMembersMap.containsKey(name);
  }

  @override
  bool get isNotEmpty => _blocMembersMap.isNotEmpty;

  @override
  bool operator ==(Object other) {
    return (other is ConcreteHub) &&
        mapEquals(other._blocMembersMap, _blocMembersMap);
  }

  @override
  int get hashCode => _blocMembersMap.hashCode;
}
