import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final TextController = TextEditingController();
  final AmmountController = TextEditingController();
  final Function trigger;

  NewTransaction(this.trigger);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: TextController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: AmmountController,
            ),
            FlatButton(
              child: Text('Add Transaction'),
              textColor: Colors.purple,
              onPressed: () {
                trigger(
                  TextController.text,
                  double.parse(AmmountController.text),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
