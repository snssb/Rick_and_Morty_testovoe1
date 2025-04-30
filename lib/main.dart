import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:testovoe1/app/app.dart';
import 'package:testovoe1/core/di/injection.dart';
import 'package:testovoe1/features/characters/data/models/character_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  final isar = Isar.open(schemas: [CharacterModelSchema], directory: dir.path);

  await configureDependencies(isar);

  runApp(const MyApp());
}
