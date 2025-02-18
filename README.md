# Flutter Bloc Mediator

[![Pub Version](https://img.shields.io/pub/v/flutter_bloc_mediator)](https://pub.dev/packages/flutter_bloc_mediator)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Flutter Version](https://img.shields.io/badge/flutter-%3E%3D2.0-blue)](https://flutter.dev)

`flutter_bloc_mediator` is a Flutter package that facilitates **message delegation between BLoCs using the Mediator pattern**. This allows BLoCs to communicate **without direct references**, improving modularity and maintainability.

---

## 🚀 Why Use This Package?

### 🛑 Common Problems with BLoC Communication:

1. **Direct Dependencies:** BLoCs referencing each other lead to tight coupling and reduced testability.
2. **Event Buses/Streams:** Can be complex and hard to manage in large applications.
3. **Global State Management:** Often introduces unnecessary complexity.

### ✅ Solution: The Mediator Pattern

Instead of BLoCs directly referencing each other, they register themselves with a **`BlocHub`** and communicate using **message passing**.

---

## 📦 Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_bloc_mediator: latest_version
```

Then, install the package:

```sh
flutter pub get
```

---

## 🛠 Usage

### 1️⃣ Define a BLoC using `BlocMember`

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
  final int value;
  CounterComType(this.value);
}
```

---

### 2️⃣ Create a `BlocHub` with `BlocHubProvider`

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

---

### 3️⃣ Register BLoCs in the `BlocHub` with unique names

```dart
final counterBlocA = CounterBloc();
final counterBlocB = CounterBloc();

blocHub.registerByName(counterBlocA, 'CounterA');
blocHub.registerByName(counterBlocB, 'CounterB');
```

---

### 4️⃣ Local Bloc Usage

```dart
final CounterABloc aBloc = CounterABloc();
final CounterBBloc bBloc = CounterBBloc();

void setBlocMembers(BuildContext context) {
  BlocHubProvider.of(context).registerByName(aBloc, "CounterABloc");
  BlocHubProvider.of(context).registerByName(bBloc, "CounterBBloc");
}

@override
void initState() {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    setBlocMembers(context);
  });
  super.initState();
}

@override
void dispose() {
  BlocHubProvider.of(context).removeByName("CounterABloc");
  BlocHubProvider.of(context).removeByName("CounterBBloc");
  super.dispose();
}
```

---

### 5️⃣ Global Bloc Usage with `MultiBlocProvider`

```dart
final CounterABloc aBloc = CounterABloc();
final CounterBBloc bBloc = CounterBBloc();

void setBlocMembers(BuildContext context) {
  BlocHubProvider.of(context).registerByName(aBloc, "CounterABloc");
  BlocHubProvider.of(context).registerByName(bBloc, "CounterBBloc");
}

@override
void initState() {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    setBlocMembers(context);
  });
  super.initState();
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

---

### 5️⃣ Send messages between BLoCs

```dart
// Inside CounterA bloc
void _incrementCounter(CounterComType event, Emitter<CounterState> emit) {
  sendTo(CounterComType(2), 'CounterB');
}
// OR
counterBlocA.sendTo(CounterComType(2), 'CounterB');
counterBlocB.sendToAll(CounterComType(2));
```

---

### 6️⃣ Managing `BlocHub` Instances

Access the `BlocHub` instance:

```dart
BlocHubProvider.of(context)
```

Register a new BLoC:

```dart
BlocHubProvider.of(context).registerByName(aBloc, "CounterABloc");
```

Remove a registered BLoC:

```dart
BlocHubProvider.of(context).removeByName("CounterABloc");
```

Clear all registered BLoCs:

```dart
BlocHubProvider.of(context).clear();
```

---

## 📌 Example Output

```
CounterB received increment event from CounterA: Counter = 1
CounterA received increment event from CounterB: Counter = 2
```

---

## 🎯 Key Benefits

✅ **Loose Coupling:** BLoCs don’t need direct references to each other.\
✅ **Better Maintainability:** Centralized communication logic in `BlocHub`.\
✅ **Improved Testability:** Easily test individual BLoCs in isolation.

---

## 🤝 Contributing

Contributions are welcome! If you have ideas for improvements or find issues, feel free to open an issue or submit a pull request.

---

## 📜 License

This package is released under the **MIT License**.

