import 'package:dio/dio.dart';
import 'package:testovoe1/core/network/network_info.dart';
import 'package:testovoe1/features/characters/data/models/character_model.dart';

abstract class CharacterRemoteDataSource {
  Future<Map<String, dynamic>> getCharacters(int page);
}

class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  final Dio dio;
  NetworkInfo networkInfo;

  CharacterRemoteDataSourceImpl({required this.dio, required this.networkInfo});

  @override
  Future<Map<String, dynamic>> getCharacters(int page) async {
    try {
      final response = await dio.get('https://rickandmortyapi.com/api/character', queryParameters: {'page': page});

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final results = data['results'] as List;
        return {
          'characters': results.map((json) => CharacterModel.fromJson(json)).toList(),
          'info': data['info'] as Map<String, dynamic>,
        };
      } else {
        throw Exception('Failed to load characters: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
