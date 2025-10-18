import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_state_mangement/pages/favlist_screen.dart';
import 'package:provider_state_mangement/provider/favourite_provider.dart';

class Favouritepage extends StatefulWidget {
  const Favouritepage({Key? key}) : super(key: key);

  @override
  State<Favouritepage> createState() => _FavouritepageState();
}

class _FavouritepageState extends State<Favouritepage> {
  @override
  Widget build(BuildContext context) {
    // final listProvider = Provider.of<FavouriteProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite,color: Colors.white,),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: ((context) => FavListScreen())));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 100,
              itemBuilder: (context, index) {
                return Consumer<FavouriteProvider>(
                  builder: (context, value, child) {
                    return ListTile(
                      onTap: () {
                        if (value.seletItem.contains(index)) {
                          value.removeSelectItem(index);
                        } else {
                          value.setSelectItem(index);
                        }
                      },
                      title: Text('Item $index'),
                      trailing: Icon(value.seletItem.contains(index)
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
