import 'package:bloc_communicatiom/bloc/cubit/internet_cubit.dart';
import 'package:bloc_communicatiom/constants/enum.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/cubit/counter_cubit_bloc.dart';
import 'logic/routes.dart';

main() {
  runApp(MyApp(
    appRoutes: ApplicationRoutes(),
    connectivity: Connectivity(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRoutes, required this.connectivity})
      : super(key: key);

  final ApplicationRoutes appRoutes;
  final Connectivity connectivity;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CounterCubitBloc()),
        BlocProvider(
            create: (context) => InternetCubit(connectivity: connectivity))
      ],
      child: MaterialApp(
          title: "flutter demo",
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          onGenerateRoute: appRoutes.onGeneratedRoute),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, InternetState>(
      listener: (context, state) {
        if (state is InternetConnected &&
            state.connectionType == ConnectionTypes.mobile) {
          context.read<CounterCubitBloc>().increment();
        } else if (state is InternetConnected &&
            state.connectionType == ConnectionTypes.wifi) {
          //context.bloc is depricated and replaced with read
          context.read<CounterCubitBloc>().decrement();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("flutter demo 1"),
        ),
        body: Column(
          children: [
            const SizedBox(height: 60),
            BlocBuilder<InternetCubit, InternetState>(
              builder: (context, state) {
                if (state is InternetConnected &&
                    state.connectionType == ConnectionTypes.mobile) {
                  return Text("Mobile");
                } else if (state is InternetConnected &&
                    state.connectionType == ConnectionTypes.wifi) {
                  return Text("Wifi");
                } else {
                  return Text("Please connect internet");
                }
              },
            ),
            //Bloc Consumer - Combination of blocBuilder and blocListener
            BlocConsumer<CounterCubitBloc, CounterCubitState>(
                builder: (context, state) {
              if (state.counter == 3) {
                return Text("Counter value  increased 10%..${state.counter}");
              }
              return Text("Successively increased ${state.counter}");
            }, listener: ((context, state) {
              if (state.isIncremented!) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text("the count is incremented to ${state.counter}"),
                    duration: const Duration(milliseconds: 1000),
                  ),
                );
              } else if (state.isIncremented == false) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text("the  count is decremented to ${state.counter}"),
                    duration: const Duration(milliseconds: 1000),
                  ),
                );
              }
            })),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    BlocProvider.of<CounterCubitBloc>(context).increment();
                  },
                  tooltip: "Increment",
                  backgroundColor: Colors.black,
                  child: const Icon(Icons.add),
                ),
                FloatingActionButton(
                  heroTag: null,
                  tooltip: "decrement",
                  backgroundColor: Colors.black,
                  onPressed: () {
                    BlocProvider.of<CounterCubitBloc>(context).decrement();
                  },
                  child: const Icon(Icons.remove),
                )
              ],
            ),
            const SizedBox(height: 50),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/second');
                },
                child: const Text("go to second page")),
            const SizedBox(height: 15),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/third');
                },
                child: const Text("go to Third page"))
          ],
        ),
      ),
    );
  }
}
