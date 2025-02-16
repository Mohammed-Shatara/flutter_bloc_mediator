import 'bloc_member.dart';

/// A wrapper class representing a registered BLoC member in the [BlocHub].
///
/// Each `Member` instance holds a unique [name] and a reference to the
/// associated BLoC [child] that implements [BlocMember].
class Member {
  /// The unique name of the registered BLoC.
  String name;

  /// The BLoC instance associated with this member.
  BlocMember child;

  /// Creates a [Member] with a given [name] and associated BLoC [child].
  Member(this.name, this.child);
}
