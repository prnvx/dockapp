import 'package:dockapp/view/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'viewmodel/dockview.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => DockViewModel(),
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
      title: 'Draggable Dock',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
