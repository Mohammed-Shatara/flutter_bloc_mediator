import '../communication_types/base_communication.dart';
import 'hub.dart';

/// A mixin that enables a BLoC to communicate within a [BlocHub].
///
/// `BlocMember` allows a BLoC to send and receive messages without direct
/// dependencies on other BLoCs. Instead, it interacts with a `BlocHub`
/// to facilitate communication using the Mediator pattern.
mixin BlocMember {
  /// The [BlocHub] instance managing this BLoC's communication.
  late BlocHub blocHub;

  /// The unique name of this BLoC within the [BlocHub].
  late String name;

  /// Handles messages received from other BLoCs.
  ///
  /// - [from]: The name of the sender BLoC.
  /// - [data]: The message payload, which extends [CommunicationType].
  ///
  /// This method must be implemented by the BLoC using this mixin.
  void receive(String from, CommunicationType data);

  /// Sends a message to a specific BLoC by its registered name.
  ///
  /// - [data]: The message payload, which extends [CommunicationType].
  /// - [receiverName]: The name of the target BLoC.
  ///
  /// This method delegates message delivery to the `BlocHub`.
  void sendTo(CommunicationType data, String receiverName) {
    blocHub.sendToByName(name, data, receiverName);
  }

  /// Broadcasts a message to all other registered BLoCs.
  ///
  /// - [data]: The message payload, which extends [CommunicationType].
  ///
  /// The message is sent to all registered BLoCs except the sender.
  void sendToAll(CommunicationType data) {
    blocHub.sendToAll(name, data);
  }
}
