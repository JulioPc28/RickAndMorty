


import 'package:dartz/dartz.dart';
import 'package:mpos_global_inc_test/src/core/errors/failure.dart';
import 'package:mpos_global_inc_test/src/domain/entitites/character.dart';
import 'package:mpos_global_inc_test/src/domain/repositories/character_repository.dart';
import 'package:mpos_global_inc_test/src/domain/usecases/usecase.dart';

class GetAllCharacters implements UseCase<List<Character>, Params> {
  final CharacterRepository repository;

  GetAllCharacters(this.repository);

  @override
  Future<Either<Failure, List<Character>>> call(Params params) async {
    return await repository.getCharacters(params.page);
  }
}

class Params {
  final int page;

  Params({required this.page});
}
