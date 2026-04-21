// ignore_for_file: depend_on_referenced_packages
import 'package:dartz/dartz.dart';
import 'package:mpos_global_inc_test/src/core/errors/exceptions.dart';
import 'package:mpos_global_inc_test/src/core/errors/failure.dart';
import 'package:mpos_global_inc_test/src/data/datasources/character_remote_data_source.dart';
import 'package:mpos_global_inc_test/src/domain/entitites/character.dart';
import 'package:mpos_global_inc_test/src/domain/repositories/character_repository.dart';


/// Implementación del repositorio del dominio.
/// Se encarga de decidir cómo obtener los datos y cómo manejar los errores.
class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource remoteDataSource;

  /// Se inyecta el datasource para mantener el desacoplamiento
  CharacterRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Character>>> getCharacters(int page) async {
    try {
      /// Se obtienen los personajes desde la API
      final characters = await remoteDataSource.getCharacters(page);

      /// Si todo sale bien, se retorna la lista
      return Right(characters);
    } on ServerException {
      /// Si ocurre un error técnico, se convierte en un Failure
      return const Left(ServerFailure('An error has occurred on the server.'));
    }
  }

  @override
  Future<Either<Failure, Character>> getCharacterById(int id) async {
    try {
      /// Se obtiene un personaje por su id
      final character = await remoteDataSource.getCharacterById(id);
      return Right(character);
    } on ServerException {
      /// Manejo de errores del servidor
      return const Left(ServerFailure('An error has occurred on the server.'));
    }
  }

  @override
  Future<Either<Failure, List<Character>>> searchCharacters(String query) async {
    try {
      /// Se buscan personajes por nombre
      final characters = await remoteDataSource.searchCharacters(query);
      return Right(characters);
    } on NotFoundException {
      /// Cuando no se encuentran resultados
      return const Left(NotFoundFailure('No characters found.'));
    } on ServerException {
      /// Error general del servidor
      return const Left(ServerFailure('An error has occurred on the server.'));
    }
  }
}

