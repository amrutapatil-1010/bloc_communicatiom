import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cubit/counter_cubit_bloc.dart';

class ThirdScreen extends StatefulWidget {
  final String title;
  const ThirdScreen({required this.title, super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: Theme.of(context).primaryTextTheme.bodyMedium,
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 60),
            const Text("You have pushed button these any times..."),
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
                  onPressed: () {
                    BlocProvider.of<CounterCubitBloc>(context).increment();
                  },
                  heroTag: null,
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
                onPressed: () {}, child: const Text("go to next page"))
          ],
        ));
  }
}
