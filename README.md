# Flutter Bloc Mediator

## Overview

`flutter_bloc_mediator` is a Flutter package that facilitates message delegation between BLoCs using the Mediator pattern. This package enables BLoCs to communicate without requiring direct references to each other, promoting better modularity and separation of concerns.

## Problem Statement

In traditional Flutter applications using `flutter_bloc`, BLoCs often need to communicate with each other. The common approaches to solving this problem include:

1. **Direct Dependencies:** A BLoC holds a reference to another BLoC instance, leading to tight coupling and making unit testing harder.
2. **Event Subscription:** Using event buses or streams, which can become difficult to manage as the application grows.
3. **Global State Management Solutions:** While effective, these can introduce unnecessary complexity for simple communication needs.

### Solution

The `flutter_bloc_mediator` package implements the **Mediator Pattern** to decouple BLoCs. Instead of referencing other BLoCs directly, each BLoC registers itself to a `BlocHub` and can send messages to other BLoCs using their registered names.

## Installation

Add the dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_bloc_mediator: latest_version
```

Then, run:

```sh
flutter pub get
```

## Usage

### 1. Define a BLoC using `BlocMember` mixin

```dart
import 'package:flutter_bloc_mediator/flutter_bloc_mediator.dart';

class CounterBloc with BlocMember {
  int counter = 0;

  @override
  void receive(String from, CommunicationType data) {
    if (data is CounterComType) {
      counter += data.value;
      print('$name received increment event from $from: Counter = $counter');
    }
  }
}

class CounterComType extends CommunicationType {
  final int data;
  CounterComType(this.data);
}
```

### 2. Create a `ConcreteHub` instance with `BlocHubProvider`

```dart
void main() {
  final blocHub = ConcreteHub();

  runApp(
    BlocHubProvider(
      blocHub: blocHub,
      child: MyApp(),
    ),
  );
}
```

### 3. Register BLoCs with unique names

```dart
final counterBlocA = CounterBloc();
final counterBlocB = CounterBloc();

blocHub.registerByName(counterBlocA, 'CounterA');
blocHub.registerByName(counterBlocB, 'CounterB');
```

### 4. Local Bloc Usage

For local bloc usage:

```dart
final CounterABloc aBloc = CounterABloc();
final CounterBBloc bBloc = CounterBBloc();

void setBlocMembers(BuildContext context) {
  BlocHubProvider.of(context).registerByName(aBloc, "CounterABloc");
  BlocHubProvider.of(context).registerByName(bBloc, "CounterBBloc");
}

@override
void didChangeDependencies() {
  setBlocMembers(context);
  super.didChangeDependencies();
}

@override
void dispose() {
  BlocHubProvider.of(context).removeByName("CounterABloc");
  BlocHubProvider.of(context).removeByName("CounterBBloc");
  super.dispose();
}
```

### 5. Global Bloc Usage

For global bloc usage:

```dart
final CounterABloc aBloc = CounterABloc();
final CounterBBloc bBloc = CounterBBloc();

void setBlocMembers(BuildContext context) {
  BlocHubProvider.of(context).registerByName(aBloc, "CounterABloc");
  BlocHubProvider.of(context).registerByName(bBloc, "CounterBBloc");
}

@override
void didChangeDependencies() {
  setBlocMembers(context);
  super.didChangeDependencies();
}

MultiBlocProvider(
  providers: [
    BlocProvider<CounterABloc>(create: (context) => aBloc,),
    BlocProvider<CounterBBloc>(create: (context) => bBloc,)
  ],
  child: MaterialApp(
    title: 'Flutter Bloc Mediator Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: const MyHomePage(),
  ),
);
```

### 6. Managing BlocHub Instances

You can access the `BlocHub` instance using:

```dart
BlocHubProvider.of(context)
```

To register a new member:

```dart
BlocHubProvider.of(context).registerByName(aBloc, "CounterABloc");
```

To remove a registered bloc by name:

```dart
BlocHubProvider.of(context).removeByName("CounterABloc");
```

To clear all registered bloc members:

```dart
BlocHubProvider.of(context).clear();
```

### Example Output

```
CounterB received increment event from CounterA: Counter = 1
CounterA received increment event from CounterB: Counter = 2
```

## Benefits

- **Loose Coupling:** BLoCs do not need direct references to each other.
- **Better Maintainability:** Communication logic is centralized in `BlocHub`.
- **Improved Testability:** Individual BLoCs can be tested in isolation without worrying about dependencies.

## Contributing

Contributions are welcome! Feel free to open an issue or submit a pull request.

## License

This package is released under the MIT License.
