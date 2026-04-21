// ignore_for_file: depend_on_referenced_packages

import 'package:equatable/equatable.dart';

/// Clase base para todos los eventos del CharacterBloc.
/// Un evento representa una acción del usuario o del sistema.
abstract class CharacterEvent extends Equatable {
  const CharacterEvent();
  @override
  List<Object> get props => [];
}

/// Evento para cargar la lista de personajes.
/// Se dispara por ejemplo al iniciar la pantalla o al hacer scroll.
class GetCharactersEvent extends CharacterEvent {}



/// Evento para buscar personajes por texto.
class SearchCharactersEvent extends CharacterEvent {
  final String query;
  const SearchCharactersEvent(this.query);
  /// Se usa para comparar correctamente eventos de búsqueda
  @override
  List<Object> get props => [query];
}



/// Evento para limpiar la búsqueda y volver al listado inicial.
class ClearSearchEvent extends CharacterEvent {}