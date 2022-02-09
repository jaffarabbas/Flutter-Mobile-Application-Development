import 'package:flutter/material.dart';

class UserList extends StatefulWidget {
  int itemCount;
  List snapshot;
  UserList({Key? key, required this.itemCount,required this.snapshot}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.itemCount,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(
              widget.snapshot[index].name
            ),
            subtitle: Text(
              widget.snapshot[index].city
            ),
          ),
        );
      },
    );
  }
}
