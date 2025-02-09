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

### 2. Create a `ConcreteHub` instance

```dart
final blocHub = ConcreteHub();
```

### 3. Register BLoCs with unique names

```dart
final counterBlocA = CounterBloc();
final counterBlocB = CounterBloc();

blocHub.registerByName(counterBlocA, 'CounterA');
blocHub.registerByName(counterBlocB, 'CounterB');
```

### 4. Send messages between BLoCs

```dart
// Inside CounterA bloc
void _incrementCounter(CounterComType event, Emitter<CounterState> emit) {
  sendTo(CounterComType(2), 'CounterB');
}
// OR
counterBlocA.sendTo(CounterComType(2), 'CounterB');
counterBlocB.sendToAll(CounterComType(2));
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
