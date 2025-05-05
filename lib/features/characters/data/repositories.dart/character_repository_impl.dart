import 'package:testovoe1/core/network/network_info.dart';
import 'package:testovoe1/features/characters/data/datasources/character_local_datasource.dart';
import 'package:testovoe1/features/characters/data/datasources/character_remote_datasource.dart';
import 'package:testovoe1/features/characters/data/models/character_model.dart';
import 'package:testovoe1/features/characters/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource remoteDataSource;
  final CharacterLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CharacterRepositoryImpl({required this.remoteDataSource, required this.localDataSource, required this.networkInfo});

  @override
  Future<Map<String, dynamic>> getCharacters(int page) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.getCharacters(page);
        final remoteCharacters = result['characters'] as List<CharacterModel>;
        await localDataSource.cacheCharacters(remoteCharacters);
        return {'characters': remoteCharacters.map((model) => model.toEntity()).toList(), 'info': result['info']};
      }
      final localCharacters = await localDataSource.getCachedCharacters();
      return {
        'characters': localCharacters.map((model) => model.toEntity()).toList(),
        'info': {'next': null},
      };
    } catch (e) {
      final localCharacters = await localDataSource.getCachedCharacters();
      return {
        'characters': localCharacters.map((model) => model.toEntity()).toList(),
        'info': {'next': null},
      };
    }
  }
}
