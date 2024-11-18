import 'package:flutter/material.dart';
import 'package:media_player_app/screen/home/provider/home_provider.dart';
import 'package:media_player_app/utils/routes.dart';
import 'package:provider/provider.dart';


// Add GitHub Repositories
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider(),),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "playlist",
      routes: AllRoutes.appRoutes,
    );
  }
}
