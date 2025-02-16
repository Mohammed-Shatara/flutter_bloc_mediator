import 'package:flutter/widgets.dart';

import 'hub.dart';

/// A provider for managing a [BlocHub] instance in the widget tree.
///
/// `BlocHubProvider` ensures that a single instance of [BlocHub] is available
/// to all registered BLoCs within the widget subtree.
class BlocHubProvider extends InheritedWidget {
  /// The [BlocHub] instance managed by this provider.
  final BlocHub blocHub;

  /// Creates a [BlocHubProvider] that injects [blocHub] into the widget tree.
  const BlocHubProvider({
    Key? key,
    required this.blocHub,
    required Widget child,
  }) : super(key: key, child: child);

  /// Retrieves the nearest [BlocHub] instance from the widget tree.
  ///
  /// This method should be used inside BLoCs or widgets that need access
  /// to the shared `BlocHub` instance.
  static BlocHub of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<BlocHubProvider>();
    assert(provider != null, 'No BlocHubProvider found in context');
    return provider!.blocHub;
  }

  @override
  bool updateShouldNotify(BlocHubProvider oldWidget) =>
      blocHub != oldWidget.blocHub;
}
