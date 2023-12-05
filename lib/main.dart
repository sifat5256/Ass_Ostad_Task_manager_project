import 'package:apps/screen/splash_screen.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const Myapps());
}
class Myapps extends StatelessWidget {
  const Myapps({super.key});
static GlobalKey<NavigatorState> navigatorkey=GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey:navigatorkey ,
      debugShowCheckedModeBanner: false,
      home:const Splashscreen(),
      theme: ThemeData(
        inputDecorationTheme:const InputDecorationTheme(
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            )
        ),

        textTheme:const TextTheme(
          titleLarge: TextStyle(
            fontSize: 32,fontWeight: FontWeight.w600
          )
        ),
        primaryColor: Colors.green,
        primarySwatch: Colors.green,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding:const EdgeInsets.symmetric(vertical: 10),
          )
        )
      ),
    );
  }
}
