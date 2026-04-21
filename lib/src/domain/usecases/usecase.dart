// ignore_for_file: depend_on_referenced_packages, avoid_types_as_parameter_names

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mpos_global_inc_test/src/core/errors/failure.dart';

/// Clase base para todos los casos de uso.
/// Define una forma estándar de ejecutar acciones del dominio.
abstract class UseCase<Type, Params> {
  /// Método que ejecuta el caso de uso.
  /// Retorna un Either con éxito o error y recibe parámetros.
  Future<Either<Failure, Type>> call(Params params);
}

/// Clase usada cuando un caso de uso no necesita parámetros.
/// Evita enviar null y mantiene el código consistente.
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
