import 'package:flutter/cupertino.dart';
import 'package:media_player_app/screen/home/screen/home_screen.dart';
import 'package:media_player_app/screen/play_list/screen/play_list_screen.dart';

class AllRoutes
{
  static String home = "home";
  static String playlist = "playlist";

     static Map<String,WidgetBuilder> appRoutes =
     {
       "home" : (context) => const HomeScreen(),
       "playlist" : (context) => const PlayListScreen(),
     };
}