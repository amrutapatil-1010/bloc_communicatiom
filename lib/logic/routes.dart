import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cubit/counter_cubit_bloc.dart';
import '../main.dart';
import '../screens/second_screen.dart';
import '../screens/third_screen.dart';

class ApplicationRoutes {
  final CounterCubitBloc _counterCubitBloc = CounterCubitBloc();

  ///create onGenerateROute function
  Route? onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _counterCubitBloc,
                  child: const HomeScreen(),
                ));
        break;
      case '/second':
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _counterCubitBloc,
                  child: const SecondScreen(title: "Welcome to second screen"),
                ));
        break;
      case '/third':
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _counterCubitBloc,
                  child: const ThirdScreen(title: "Welcome to third screen"),
                ));
      default:
        return null;
    }
  }

  dispose() {
    _counterCubitBloc.close();
  }
}
