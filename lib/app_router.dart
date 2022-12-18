import 'package:flutter/material.dart';
import 'package:my_radio_finder/model/radio_station.dart';
import 'package:my_radio_finder/page/main/page_main.dart';
import 'package:my_radio_finder/page/station/page_station.dart';
import 'package:my_radio_finder/route_name.dart';

class AppRouter {
  static PageMain main = const PageMain();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arg = settings.arguments;

    switch (settings.name) {
      case RouteName.main:
        return MaterialPageRoute(
            settings: _routeSettings(settings), builder: (context) => main);
      case RouteName.station:
        return MaterialPageRoute(
            settings: _routeSettings(settings),
            builder: (context) => PageStation(
                  station: arg as RadioStation,
                ));
      default:
        return MaterialPageRoute(
          settings: _routeSettings(settings),
          builder: (context) => Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
            ),
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }

  static RouteSettings _routeSettings(RouteSettings settings) =>
      RouteSettings(name: settings.name, arguments: settings.arguments);
}
