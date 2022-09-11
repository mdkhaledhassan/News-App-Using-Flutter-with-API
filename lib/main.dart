import 'package:flutter/material.dart';
import 'package:news_app/Provider/news_provider.dart';
import 'package:news_app/home_page.dart';
import 'package:news_app/news_details.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NewsProvider(),
        )
      ],
      child: MaterialApp(
          routes: {NewsDetails.routeName: (context) => NewsDetails()},
          debugShowCheckedModeBanner: false,
          home: HomePage()),
    );
  }
}
