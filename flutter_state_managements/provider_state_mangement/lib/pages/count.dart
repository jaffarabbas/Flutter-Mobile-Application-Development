import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:provider_state_mangement/provider/count_provider.dart';
import 'package:provider_state_mangement/provider/slider_provider.dart';

class CountPage extends StatefulWidget {
  const CountPage({Key? key}) : super(key: key);

  @override
  State<CountPage> createState() => _CountPageState();
}

class _CountPageState extends State<CountPage> {
  // double value = 0.1;
  @override
  Widget build(BuildContext context) {
    final countProvider = Provider.of<CountProvider>(context, listen: false);
    final sliderProvider = Provider.of<SliderProvider>(context, listen: false);
    print('build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: Consumer<CountProvider>(
              builder: (context, value, child) {
                return Text(
                  value.count.toString(),
                  style: TextStyle(fontSize: 20),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Consumer<SliderProvider>(
            builder: (context, value, child) {
              return Slider(
                min: 0,
                max: 1,
                value: sliderProvider.value,
                onChanged: (val) {
                  sliderProvider.setValue(val);
                },
              );
            },
          ),
          const SizedBox(height: 20),
          Consumer<SliderProvider>(
            builder: (context, value, child) {
              return Row(
                children: [
                  Expanded(
                      child: Container(
                    alignment: Alignment.center,
                    height: 200,
                    color: Colors.red.withOpacity(value.value),
                    child: Text('Container 1'),
                  )),
                  Expanded(
                      child: Container(
                    alignment: Alignment.center,
                    height: 200,
                    color: Colors.green.withOpacity(value.value),
                    child: Text('Container 2'),
                  )),
                ],
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          countProvider.setCount();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
