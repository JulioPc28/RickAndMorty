// ignore_for_file: depend_on_referenced_packages
import 'package:equatable/equatable.dart';

/// Clase base para los eventos del detalle del personaje.
/// Un evento representa una acción que debe manejar el Bloc.
abstract class CharacterDetailEvent extends Equatable {
  const CharacterDetailEvent();

  @override
  List<Object> get props => [];
}

/// Evento para solicitar el detalle de un personaje.
/// Contiene el id del personaje que se desea cargar.
class GetCharacterDetailEvent extends CharacterDetailEvent {
  final int id;
  const GetCharacterDetailEvent(this.id);
  @override
  List<Object> get props => [id];
}