// ignore_for_file: depend_on_referenced_packages
import 'package:dartz/dartz.dart';
import 'package:mpos_global_inc_test/src/core/errors/failure.dart';
import 'package:mpos_global_inc_test/src/domain/entitites/character.dart';

/// Contrato del repositorio del dominio.
/// Define QUÉ operaciones se pueden hacer con los personajes,
/// pero NO dice cómo ni desde dónde se obtienen los datos.
abstract class CharacterRepository {

  Future<Either<Failure, List<Character>>> getCharacters(int page);    /// Obtiene una lista de personajes paginada
  Future<Either<Failure, Character>> getCharacterById(int id);   /// Obtiene el detalle de un personaje por su id
  Future<Either<Failure, List<Character>>> searchCharacters(String query);    /// Busca personajes por nombre
  
}
