import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_types/features/bloc/counter_bloc.dart';

class CounterSnackBar extends StatefulWidget {
  const CounterSnackBar({super.key});

  @override
  State<CounterSnackBar> createState() => _CounterSnackBarState();
}

class _CounterSnackBarState extends State<CounterSnackBar> {
  final CounterBloc counterBloc = CounterBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Text('Bloc Types'),
      ),
      body: BlocListener<CounterBloc, CounterState>(
        bloc: counterBloc,
        listener: (context, state) {
          if (state is CounterShowSnackBarSateActionState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Hello')));
          }
        },
        child: Center(
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        counterBloc.add(CounterSnackBarEvent());
                      },
                      child: Text("Press")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
