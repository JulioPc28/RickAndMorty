import 'package:dartz/dartz.dart';
import 'package:mpos_global_inc_test/src/core/errors/failure.dart';
import 'package:mpos_global_inc_test/src/domain/entitites/character.dart';
import 'package:mpos_global_inc_test/src/domain/repositories/character_repository.dart';
import 'package:mpos_global_inc_test/src/domain/usecases/usecase.dart';


class GetCharacterById implements UseCase<Character, CharacterByIdParams> {
  final CharacterRepository repository;

  GetCharacterById(this.repository);

  @override
  Future<Either<Failure, Character>> call(CharacterByIdParams params) async {
    return await repository.getCharacterById(params.id);
  }
}

class CharacterByIdParams {
  final int id;

  CharacterByIdParams({required this.id});
}
