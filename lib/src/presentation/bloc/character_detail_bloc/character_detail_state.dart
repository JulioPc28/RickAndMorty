// ignore_for_file: depend_on_referenced_packages
import 'package:equatable/equatable.dart';
import 'package:mpos_global_inc_test/src/domain/entitites/character.dart';

/// Clase base para todos los estados del detalle del personaje.
/// Representa la situación actual de la pantalla de detalle.
abstract class CharacterDetailState extends Equatable {
  const CharacterDetailState();

  @override
  List<Object> get props => [];
}

/// Estado inicial cuando aún no se ha cargado el detalle.
class CharacterDetailInitial extends CharacterDetailState {}

/// Estado mientras se está cargando el detalle del personaje.
class CharacterDetailLoading extends CharacterDetailState {}

/// Estado cuando el personaje se cargó correctamente.
/// Contiene el personaje a mostrar en la UI.
class CharacterDetailLoaded extends CharacterDetailState {
  final Character character;

  const CharacterDetailLoaded(this.character);

  @override
  List<Object> get props => [character];
}

/// Estado cuando ocurre un error al cargar el detalle.
class CharacterDetailError extends CharacterDetailState {
  final String message;
  const CharacterDetailError(this.message);
  @override
  List<Object> get props => [message];
}