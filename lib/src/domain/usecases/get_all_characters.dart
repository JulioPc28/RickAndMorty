// ignore_for_file: depend_on_referenced_packages
import 'package:dartz/dartz.dart';
import 'package:mpos_global_inc_test/src/core/errors/failure.dart';
import 'package:mpos_global_inc_test/src/domain/entitites/character.dart';
import 'package:mpos_global_inc_test/src/domain/repositories/character_repository.dart';
import 'package:mpos_global_inc_test/src/domain/usecases/usecase.dart';

/// Caso de uso que se encarga de obtener todos los personajes.
/// Representa una acción específica que puede realizar la aplicación.
class GetAllCharacters implements UseCase<List<Character>, Params> {
  final CharacterRepository repository;

  /// Se recibe el repositorio por inyección de dependencias
  GetAllCharacters(this.repository);

  @override
  Future<Either<Failure, List<Character>>> call(Params params) async {
    /// Se delega la obtención de los datos al repositorio
    return await repository.getCharacters(params.page);
  }
}

/// Parámetros necesarios para ejecutar el caso de uso.
/// En este caso, solo se necesita la página.
class Params {
  final int page;
  Params({required this.page});
}