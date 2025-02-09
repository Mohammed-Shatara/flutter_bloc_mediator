import 'package:example/blocs/counter_a/counter_a_bloc.dart';
import 'package:flutter_bloc_mediator/bloc_hub/concrete_hub.dart';
import 'package:flutter_bloc_mediator/bloc_hub/hub.dart';
import 'package:get_it/get_it.dart';

import 'blocs/counter_b/counter_b_bloc.dart';

final locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton<BlocHub>(() => ConcreteHub());
  locator.registerLazySingleton(() => CounterABloc());
  locator.registerLazySingleton(() => CounterBBloc());
  locator<BlocHub>().registerByName(locator<CounterABloc>(), 'CounterABloc');
  locator<BlocHub>().registerByName(locator<CounterBBloc>(), 'CounterBBloc');
}
