import 'package:flutter/material.dart';
import 'package:my_radio_finder/route_name.dart';

import 'app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Radio finder',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      initialRoute: RouteName.main,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}