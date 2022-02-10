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
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.itemCount,
      itemBuilder: (context, index) {
        return Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 250,
                child: ListTile(
                  title: Text(
                    '${widget.snapshot[index].id} ${widget.snapshot[index].name} ROll : ${widget.snapshot[index].roll}'
                  ),
                  subtitle: Text(
                    widget.snapshot[index].city
                  ),
                ),
              ),
              Container(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.mode_edit_rounded,color: Colors.blueAccent,)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.delete,color: Colors.blueAccent,)),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
