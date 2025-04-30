import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:testovoe1/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:testovoe1/features/characters/presentation/screens/main_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(create: (context) => GetIt.instance<CharactersBloc>(), child: const MainScreen()),
    );
  }
}
