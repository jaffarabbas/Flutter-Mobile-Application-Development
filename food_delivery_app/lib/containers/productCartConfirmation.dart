// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class CartConfirmation extends StatefulWidget {
  const CartConfirmation({Key? key}) : super(key: key);

  @override
  _CartConfirmationState createState() => _CartConfirmationState();
}

class _CartConfirmationState extends State<CartConfirmation> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    void Counter(bool flag) {
      if (flag) {
        setState(() {
          count++;
        });
      } else {
        setState(() {
          if (count != 0) {
            count--;
          }
        });
      }
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // color: Colors.deepPurple,
            width: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.calendar_today,
                  color: Colors.red,
                  size: 30,
                ),
                Text(
                  '0.5 km Distance',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            child: Row(
              children: [
                InkWell(
                  onTap: () => Counter(false),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.red,
                    child: Text('-',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text('${count}',
                      style: TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.bold)),
                ),
                InkWell(
                  onTap: () {
                    Counter(true);
                  },
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.red,
                    child: Text('+',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 30),
                  width: 170,
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.shopping_cart_sharp,
                        color: Colors.white,
                      ),
                      Text('Add to Cart',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
