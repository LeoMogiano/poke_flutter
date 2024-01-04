
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:examen_server/route/routes_app.dart';
import 'package:examen_server/services/poke_service.dart';

void main() async {
 
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => PokeService()),
    ], 
    child: const MyApp() 
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: MaterialApp(
           theme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor:  Color(0xFF0075BE),
          
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.getAppRoutes(),
    ));
  }
}



