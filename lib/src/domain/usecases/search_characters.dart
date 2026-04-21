// ignore_for_file: depend_on_referenced_packages
import 'package:dartz/dartz.dart';
import 'package:mpos_global_inc_test/src/core/errors/failure.dart';
import 'package:mpos_global_inc_test/src/domain/entitites/character.dart';
import 'package:mpos_global_inc_test/src/domain/repositories/character_repository.dart';
import 'package:mpos_global_inc_test/src/domain/usecases/usecase.dart';

/// Caso de uso para buscar personajes por texto.
/// Representa la acción de negocio de realizar una búsqueda.
class SearchCharacters  implements UseCase<List<Character>, SearchCharactersParams> {
  final CharacterRepository repository;

  /// Se recibe el repositorio por inyección de dependencias
  SearchCharacters(this.repository);

  @override
  Future<Either<Failure, List<Character>>> call(SearchCharactersParams params) async {
    /// Se delega la búsqueda al repositorio
    return await repository.searchCharacters(params.query);
  }
}

/// Parámetros necesarios para ejecutar el caso de uso.
/// En este caso, el texto de búsqueda.
class SearchCharactersParams {
  final String query;
  SearchCharactersParams({required this.query});
}