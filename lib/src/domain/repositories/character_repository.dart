
import 'package:dartz/dartz.dart';
import 'package:mpos_global_inc_test/src/core/errors/failure.dart';
import 'package:mpos_global_inc_test/src/domain/entitites/character.dart';



abstract class CharacterRepository {
  Future<Either<Failure, List<Character>>> getCharacters(int page);
  Future<Either<Failure, Character>> getCharacterById(int id);
  Future<Either<Failure, List<Character>>> searchCharacters(String query);
}
