import 'package:dartz/dartz.dart';
import 'package:mpos_global_inc_test/src/core/errors/exceptions.dart';
import 'package:mpos_global_inc_test/src/core/errors/failure.dart';
import 'package:mpos_global_inc_test/src/data/datasources/character_remote_data_source.dart';
import 'package:mpos_global_inc_test/src/domain/entitites/character.dart';
import 'package:mpos_global_inc_test/src/domain/repositories/character_repository.dart';


class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource remoteDataSource;

  CharacterRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Character>>> getCharacters(int page) async {
    try {
      final characters = await remoteDataSource.getCharacters(page);
      return Right(characters);
    } on ServerException {
      return const Left(ServerFailure('An error has occurred on the server.'));
    }
  }

  @override
  Future<Either<Failure, Character>> getCharacterById(int id) async {
    try {
      final character = await remoteDataSource.getCharacterById(id);
      return Right(character);
    } on ServerException {
      return const Left(ServerFailure('An error has occurred on the server.'));
    }
  }

  @override
  Future<Either<Failure, List<Character>>> searchCharacters(String query) async {
    try {
      final characters = await remoteDataSource.searchCharacters(query);
      return Right(characters);
    } on NotFoundException {
      return const Left(NotFoundFailure('No characters found.'));
    } on ServerException {
      return const Left(ServerFailure('An error has occurred on the server.'));
    }
  }
}
