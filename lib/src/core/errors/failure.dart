// ignore_for_file: depend_on_referenced_packages

import 'package:equatable/equatable.dart';

/* Clase base para representar errores de la aplicación.
 Los Failures se usan en la capa de dominio para manejar
 errores sin depender de excepciones técnicas. */

abstract class Failure extends Equatable {
  /// Mensaje que describe el error
  final String message;
  const Failure(this.message);
  
  @override
  List<Object> get props => [message];
}

/// Error cuando ocurre un problema con el servidor.
/// Normalmente viene de un ServerException.
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Error cuando no se encuentra información.
/// Normalmente viene de un NotFoundException.
class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}