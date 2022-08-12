import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_state_mangement/provider/favourite_provider.dart';

class FavListScreen extends StatefulWidget {
  FavListScreen({Key? key}) : super(key: key);

  @override
  State<FavListScreen> createState() => _FavListScreenState();
}

class _FavListScreenState extends State<FavListScreen> {
  @override
  Widget build(BuildContext context) {
    final listProvider = Provider.of<FavouriteProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Page'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<FavouriteProvider>(
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: listProvider.seletItem.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        if (value.seletItem.contains(listProvider.seletItem[index])) {
                          value.removeSelectItem(listProvider.seletItem[index]);
                        } else {
                          value.setSelectItem(listProvider.seletItem[index]);
                        }
                      },
                      title: Text('Item ${listProvider.seletItem[index]}'),
                      trailing: Icon(value.seletItem.contains(listProvider.seletItem[index])
                          ? Icons.favorite
                          : Icons.favorite_border),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
