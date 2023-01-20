import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController billAmountController = TextEditingController();
  TextEditingController tipPercentageController = TextEditingController();
  TextEditingController numberOfPeopleController = TextEditingController();

  double perPersonTip = 0.0;
  double perPersonTotal = 0.0;
  @override
  Widget build(BuildContext context) {
    void calculateTip() {
      setState(() {
        double billAmount = double.parse(billAmountController.value.text);
        double tipPercentage = double.parse(tipPercentageController.value.text);
        double numberOfPeople =
            double.parse(numberOfPeopleController.value.text);

        double tipAmount = billAmount * tipPercentage / 100;
        double totalAmount = billAmount + tipAmount;
        perPersonTip = tipAmount / numberOfPeople;
        perPersonTotal = totalAmount / numberOfPeople;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Tip Calculator'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Tip Calculator',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: billAmountController,
                decoration: InputDecoration(
                    hintText: 'Enter Bill Amount',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: numberOfPeopleController,
                decoration: InputDecoration(
                    hintText: 'Number Of People',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: tipPercentageController,
                decoration: InputDecoration(
                    hintText: 'Enter Tip %',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Per Person Tip : Rs $perPersonTip',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Per Person Total : Rs $perPersonTotal',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () => calculateTip(),
                child: Text('Calculate'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
