import '../communication_types/base_communication.dart';
import 'bloc_member.dart';
import 'member.dart';

/// An abstract class representing a central hub for managing communication
/// between different BLoCs using the Mediator pattern.
///
/// The `BlocHub` enables BLoCs to send and receive messages without
/// directly referencing each other, promoting loose coupling and better
/// modularity in Flutter applications.
abstract class BlocHub {
  /// Retrieves a list of all registered members in the hub.
  ///
  /// This method returns a list of [Member] instances that are currently
  /// registered in the hub, allowing introspection of available BLoCs.
  List<Member> getMembers();

  /// Sends a message from one BLoC to another by name.
  ///
  /// - [senderName]: The name of the sender BLoC.
  /// - [data]: The message payload, which extends [CommunicationType].
  /// - [receiverName]: The name of the target BLoC that will receive the message.
  ///
  /// If the specified `receiverName` is not registered, the message will not be delivered.
  void sendToByName(
      String senderName, CommunicationType data, String receiverName);

  /// Registers a BLoC member in the hub with a unique name.
  ///
  /// - [member]: The BLoC instance that implements [BlocMember].
  /// - [name]: A unique identifier for the BLoC in the hub.
  ///
  /// Once registered, the BLoC can send and receive messages through the hub.
  void registerByName(BlocMember member, String name);

  /// Removes a registered BLoC from the hub by its name.
  ///
  /// - [name]: The unique identifier of the BLoC to remove.
  ///
  /// If the BLoC is not found, no action is taken.
  void removeByName(String name);

  /// Clears all registered BLoC members from the hub.
  ///
  /// This method removes all entries, effectively resetting the hub.
  void clearMembers();

  /// Checks whether the hub has no registered members.
  ///
  /// Returns `true` if there are no members in the hub, otherwise `false`.
  bool get isEmpty;

  /// Checks whether the hub contains at least one registered member.
  ///
  /// Returns `true` if at least one member is registered, otherwise `false`.
  bool get isNotEmpty;

  /// Checks if a member with the given name exists in the hub.
  ///
  /// - [name]: The unique identifier of the BLoC to check.
  ///
  /// Returns `true` if the BLoC is registered, otherwise `false`.
  bool hasMember(String name);

  /// Sends a message from one BLoC to all other registered BLoCs.
  ///
  /// - [senderName]: The name of the sender BLoC.
  /// - [data]: The message payload, which extends [CommunicationType].
  ///
  /// The message will be broadcasted to all registered BLoCs except the sender.
  void sendToAll(String senderName, CommunicationType data);
}
