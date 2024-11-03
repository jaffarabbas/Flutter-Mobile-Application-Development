import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_types/features/bloc/counter_bloc.dart';

class CounterElementSnack extends StatefulWidget {
  const CounterElementSnack({super.key});

  @override
  State<CounterElementSnack> createState() => CounterElementSnackState();
}

class CounterElementSnackState extends State<CounterElementSnack> {
  @override
  void initState() {
    // TODO: implement initState
    counterBloc.add(CounterIncrementEvent());
    super.initState();
  }

  final CounterBloc counterBloc = CounterBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Text('Bloc Types'),
      ),
      body: BlocConsumer<CounterBloc, CounterState>(
        bloc: counterBloc,
        listenWhen: (previous, current) => current is CounterActionState,
        buildWhen: (previous, current) => current is! CounterActionState,
        listener: (context, state) {
          if (state is CounterShowSnackBarSateActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Increment ${state.val}')));
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case CounterIncrementState:
              final successState = state as CounterIncrementState;
              return Center(
                child: Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              counterBloc
                                  .add(CounterIncreementAndSnackBarEvent());
                            },
                            child: Text("Press")),
                        Text(
                            style: TextStyle(fontSize: 35),
                            successState.val.toString()),
                      ],
                    ),
                  ),
                ),
              );
            default:
              return Center(
                child: Container(
                  child: const Text('Not Found'),
                ),
              );
          }
        },
      ),
    );
  }
}
