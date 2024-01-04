import 'package:flutter/material.dart';
import 'package:examen_server/models/models.dart';
import 'package:examen_server/screens/screens.dart';

class AppRoutes {
  static const initialRoute = '/home';

  static final routes = <Ruta>[
   
    Ruta(route: '/home', screen:  const HomeScreen()),
    Ruta(route: '/home', screen:  const HomeScreen() ),
    
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    for (final option in routes) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }
    return appRoutes;
  }
}