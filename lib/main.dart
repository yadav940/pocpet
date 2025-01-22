import 'package:flutter/material.dart';
import 'package:poc/pages/home_page.dart';
import 'package:poc/provider/history_provider.dart';
import 'package:poc/provider/pet_provider.dart';
import 'package:poc/provider/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => PetProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
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
      title: 'Vinod\'s Demo',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).getTheme,
      home: const HomePage(),
    );
  }
}
