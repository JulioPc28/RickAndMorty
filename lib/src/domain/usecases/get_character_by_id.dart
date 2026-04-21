// ignore_for_file: depend_on_referenced_packages
import 'package:dartz/dartz.dart';
import 'package:mpos_global_inc_test/src/core/errors/failure.dart';
import 'package:mpos_global_inc_test/src/domain/entitites/character.dart';
import 'package:mpos_global_inc_test/src/domain/repositories/character_repository.dart';
import 'package:mpos_global_inc_test/src/domain/usecases/usecase.dart';

/// Caso de uso para obtener el detalle de un personaje por su id.
/// Representa una acción específica del negocio.
class GetCharacterById implements UseCase<Character, CharacterByIdParams> {
  final CharacterRepository repository;

  /// Se recibe el repositorio por inyección de dependencias
  GetCharacterById(this.repository);

  @override
  Future<Either<Failure, Character>> call(CharacterByIdParams params) async {
    /// Se delega la obtención del personaje al repositorio
    return await repository.getCharacterById(params.id);
  }
}



/// Parámetros necesarios para ejecutar el caso de uso.
/// En este caso, solo el id del personaje.
class CharacterByIdParams {
  final int id;
  CharacterByIdParams({required this.id});
}
