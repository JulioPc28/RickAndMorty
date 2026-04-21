// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:mpos_global_inc_test/src/core/errors/exceptions.dart';
import 'package:mpos_global_inc_test/src/data/models/character_model.dart';

/// Contrato del datasource remoto.
/// Define qué datos se pueden obtener desde la API.
abstract class CharacterRemoteDataSource {
  /// Obtiene una lista paginada de personajes
  Future<List<CharacterModel>> getCharacters(int page);
  /// Obtiene el detalle de un personaje por id
  Future<CharacterModel> getCharacterById(int id);
  /// Busca personajes por nombre
  Future<List<CharacterModel>> searchCharacters(String query);
}

/// Implementación del datasource remoto.
/// Aquí se consume la API usando Dio.
class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  final Dio dio;

  /// Se inyecta Dio para no acoplar la clase a una implementación concreta
  CharacterRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<CharacterModel>> getCharacters(int page) async {
    try {
      /// Llamado a la API para obtener personajes paginados
      final response = await dio.get(
        'https://rickandmortyapi.com/api/character/',
        queryParameters: {'page': page},
      );

      /// Se obtienen los resultados del JSON
      final results = response.data['results'] as List<dynamic>?;

      /// Si no hay resultados, se lanza un error de servidor
      if (results == null) throw ServerException();

      /// Se convierte el JSON a una lista de modelos
      return results
          .map((e) => CharacterModel.fromJson(e))
          .toList();
    } on DioException {
      /// Cualquier error de red o servidor se maneja como ServerException
      throw ServerException();
    }
  }

  @override
  Future<CharacterModel> getCharacterById(int id) async {
    try {
      /// Llamado a la API para obtener un personaje específico
      final response = await dio.get(
        'https://rickandmortyapi.com/api/character/$id',
      );

      /// Se convierte el JSON en un modelo
      return CharacterModel.fromJson(response.data);
    } on DioException {
      /// Error al consultar el servidor
      throw ServerException();
    }
  }

  @override
  Future<List<CharacterModel>> searchCharacters(String query) async {
    try {
      /// Llamado a la API para buscar personajes por nombre
      final response = await dio.get(
        'https://rickandmortyapi.com/api/character/',
        queryParameters: {'name': query},
      );

      final results = response.data['results'] as List<dynamic>?;

      /// Si la búsqueda no retorna datos, se maneja como no encontrado
      if (results == null) throw NotFoundException();

      /// Conversión del JSON a modelos
      return results
          .map((e) => CharacterModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      /// Si el status es 404, se lanza NotFoundException
      if (e.response?.statusCode == 404) {
        throw NotFoundException();
      }
      /// Cualquier otro error se considera error de servidor
      throw ServerException();
    }
  }
}