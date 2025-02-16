import 'package:flutter_bloc_mediator/bloc_hub/concrete_hub.dart';
import 'package:flutter_bloc_mediator/bloc_hub/hub.dart';
import 'package:get_it/get_it.dart';


final locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton<BlocHub>(() => ConcreteHub());
}
