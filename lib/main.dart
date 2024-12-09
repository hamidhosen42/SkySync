import 'package:flutter/material.dart';
import 'providers/city.dart';
import 'weather-types/types.dart';
import 'screens/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      create: (context)=> CityData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WeatherApp',
        home: const GetStarted(),
        routes: {
          MainScreen.routeName: (context) => const MainScreen(),
          WeatherType.routeName: (context) => const WeatherType(),
          CitySelectionType.routeName: (context) => const CitySelectionType(),
          SearchType.routeName: (context) => const SearchType(),
        },
      ),
    );
  }
}
