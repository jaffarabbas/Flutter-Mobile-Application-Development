import 'package:provider/provider.dart';
import 'count_provider.dart';
import 'favourite_provider.dart';
import 'slider_provider.dart';
import 'theme_changer.dart';

class ProdviderList {
  static List<ChangeNotifierProvider> providerList = [
    ChangeNotifierProvider(create: (_) => CountProvider()),
    ChangeNotifierProvider(create: (_) => SliderProvider()),
    ChangeNotifierProvider(create: (_) => FavouriteProvider()),
    ChangeNotifierProvider(create: (_) => ThemeChangerProvider()),
  ];
}
