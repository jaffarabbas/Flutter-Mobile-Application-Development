import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_practice/search_provider.dart';
//
// final counter = StateProvider<int>((ref){
//   return 0;
// });
//
// class HomeScreen extends ConsumerStatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   ConsumerState<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends ConsumerState<HomeScreen> {
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     ref.read(counter.notifier).state = 1;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//         return Scaffold(
//       appBar: AppBar(
//         title: Text('River Pod'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Consumer(builder: (context, ref, child) {
//               final subscription = ref.watch(counter);
//               return Text(subscription.toString());
//             },),
//             ElevatedButton(
//               onPressed: () {
//                 ref.read(counter.notifier).state++;
//               },
//               child: Text("Add"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final search = ref.watch(searchprovider);
    print('build');
    return Scaffold(
      appBar: AppBar(
        title: Text('River Pod'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                ref.read(searchprovider.notifier).setSearch(value);
              }
            ),
            Consumer(
              builder: (context, ref, child) {
                final subscription = ref.watch(searchprovider);
                return Text(subscription.search.toString());
              },
            ),
          ],
        ),
      ),
    );
  }
}
