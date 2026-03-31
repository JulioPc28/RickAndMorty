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
    final response = await dio.get('https://rickandmortyapi.com/api/character/?page=$page');

    if (response.statusCode == 200) {
      final results = response.data['results'] as List;
      return results.map((e) => CharacterModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<CharacterModel> getCharacterById(int id) async {
    final response = await dio.get('https://rickandmortyapi.com/api/character/$id');

    if (response.statusCode == 200) {
      return CharacterModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<CharacterModel>> searchCharacters(String query) async {
    final response = await dio.get('https://rickandmortyapi.com/api/character/?name=$query');

    if (response.statusCode == 200) {
      final results = response.data['results'] as List;
      return results.map((e) => CharacterModel.fromJson(e)).toList();
    } else if (response.statusCode == 404) {
      throw NotFoundException();
    } else {
      throw ServerException();
    }
  }
}
