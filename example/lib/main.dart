import 'package:example/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_mediator/bloc_hub/hub.dart';
import 'package:flutter_bloc_mediator/bloc_hub/provider.dart';
import 'blocs/counter_a/counter_a_bloc.dart';
import 'blocs/counter_b/counter_b_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpLocator();
  runApp(BlocHubProvider(blocHub: locator<BlocHub>(), child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterABloc>(
          create: (context) => aBloc,
        ),
        BlocProvider<CounterBBloc>(
          create: (context) => bBloc,
        )
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
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounterA(BuildContext context) {
    BlocProvider.of<CounterABloc>(context).add(IncrementAEvent());
  }

  void _incrementCounterB(BuildContext context) {
    BlocProvider.of<CounterBBloc>(context).add(IncrementBEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Flutter Bloc Mediator"),
      ),
      body: Column(
        spacing: 24,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 48.0),
            child: BlocBuilder<CounterABloc, CounterAState>(
              builder: (context, state) {
                return Column(
                  spacing: 8,
                  children: [
                    Text(
                      "Counter A:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    CounterText(
                      otherName: "B",
                      value: "${state.count}",
                      otherValue: "${state.blocBCount}",
                    )
                  ],
                );
              },
            ),
          ),
          BlocBuilder<CounterBBloc, CounterBState>(
            builder: (context, state) {
              return Column(
                spacing: 8,
                children: [
                  Text("Counter B:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  CounterText(
                    otherName: "A",
                    value: "${state.count}",
                    otherValue: "${state.blocACount}",
                  )
                ],
              );
            },
          ),
          Row(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _incrementCounterA(context),
                child: Text("Increment A"),
              ),
              ElevatedButton(
                onPressed: () => _incrementCounterB(context),
                child: Text("Increment B"),
              )
            ],
          )
        ],
      ),
    );
  }
}

class CounterText extends StatelessWidget {
  const CounterText(
      {super.key,
      required this.value,
      required this.otherValue,
      required this.otherName});

  final String value;
  final String otherValue;
  final String otherName;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: "My Value is: ",
            style: TextStyle(fontSize: 14, color: Colors.black),
            children: [
          TextSpan(
              text: value,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          TextSpan(
              text: ", while Counter",
              style: TextStyle(fontSize: 14, color: Colors.black)),
          TextSpan(
              text: " $otherName ",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          TextSpan(
              text: "value is: ",
              style: TextStyle(fontSize: 14, color: Colors.black)),
          TextSpan(
              text: otherValue,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600))
        ]));
  }
}
