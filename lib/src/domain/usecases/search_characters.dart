import 'package:dartz/dartz.dart';
import 'package:mpos_global_inc_test/src/core/errors/failure.dart';
import 'package:mpos_global_inc_test/src/domain/entitites/character.dart';
import 'package:mpos_global_inc_test/src/domain/repositories/character_repository.dart';
import 'package:mpos_global_inc_test/src/domain/usecases/usecase.dart';


class SearchCharacters implements UseCase<List<Character>, SearchCharactersParams> {
  final CharacterRepository repository;

  SearchCharacters(this.repository);

  @override
  Future<Either<Failure, List<Character>>> call(SearchCharactersParams params) async {
    return await repository.searchCharacters(params.query);
  }
}

class SearchCharactersParams {
  final String query;

  SearchCharactersParams({required this.query});
}
