import 'package:dio/dio.dart';
import 'package:mpos_global_inc_test/src/core/errors/exceptions.dart';
import 'package:mpos_global_inc_test/src/data/models/character_model.dart';

abstract class CharacterRemoteDataSource {
  Future<List<CharacterModel>> getCharacters(int page);
  Future<CharacterModel> getCharacterById(int id);
  Future<List<CharacterModel>> searchCharacters(String query);
}

class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  final Dio dio;

  CharacterRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<CharacterModel>> getCharacters(int page) async {
    try {
      final response = await dio.get(
        'https://rickandmortyapi.com/api/character/',
        queryParameters: {'page': page},
      );

      final results = response.data['results'] as List<dynamic>?;

      if (results == null) throw ServerException();

      return results
          .map((e) => CharacterModel.fromJson(e))
          .toList();
    } on DioException {
      throw ServerException();
    }
  }

  @override
  Future<CharacterModel> getCharacterById(int id) async {
    try {
      final response = await dio.get(
        'https://rickandmortyapi.com/api/character/$id',
      );

      return CharacterModel.fromJson(response.data);
    } on DioException {
      throw ServerException();
    }
  }

  @override
  Future<List<CharacterModel>> searchCharacters(String query) async {
    try {
      final response = await dio.get(
        'https://rickandmortyapi.com/api/character/',
        queryParameters: {'name': query},
      );

      final results = response.data['results'] as List<dynamic>?;

      if (results == null) throw NotFoundException();

      return results
          .map((e) => CharacterModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw NotFoundException();
      }
      throw ServerException();
    }
  }
}