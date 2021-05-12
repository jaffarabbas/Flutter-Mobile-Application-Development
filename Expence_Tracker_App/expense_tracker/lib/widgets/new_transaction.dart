import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final TextController = TextEditingController();
  final AmmountController = TextEditingController();
  final Function trigger;

  NewTransaction(this.trigger);

  void onSubmitted(){
    final title = TextController.text;
    final amount = double.parse(AmmountController.text);

    if(title.isEmpty || amount <=0 ){
      return;
    }
    trigger(
      title,
      amount,
    );
  }
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
              onSubmitted: (_)=> onSubmitted()
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: AmmountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_)=> onSubmitted()
            ),
            FlatButton(
              child: Text('Add Transaction'),
              textColor: Colors.purple,
              onPressed: onSubmitted,
            ),
          ],
        ),
      ),
    );
  }
}
