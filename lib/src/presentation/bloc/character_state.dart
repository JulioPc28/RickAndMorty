// ignore_for_file: depend_on_referenced_packages
import 'package:equatable/equatable.dart';
import 'package:mpos_global_inc_test/src/domain/entitites/character.dart';

/// Clase base para todos los estados del CharacterBloc.
/// Un estado representa cómo se encuentra la UI en un momento dado.
abstract class CharacterState extends Equatable {
  const CharacterState();
  @override
  List<Object> get props => [];
}


/// Estado inicial cuando no se ha cargado información.
class CharacterInitial extends CharacterState {}



/// Estado mientras se cargan los personajes.
/// Puede contener una lista previa para mostrar loading incremental.
class CharacterLoading extends CharacterState {
  final List<Character> characters;
  const CharacterLoading({this.characters = const []});
  @override
  List<Object> get props => [characters];
}


/// Estado cuando los personajes se cargaron correctamente.
class CharacterLoaded extends CharacterState {
  final List<Character> characters;
  final int pageNumber;
  final bool hasReachedMax;

  const CharacterLoaded({
    required this.characters,
    this.pageNumber = 1,
    this.hasReachedMax = false,
  });
  @override
  List<Object> get props => [characters, pageNumber, hasReachedMax];
}


/// Estado cuando ocurre un error.
class CharacterError extends CharacterState {
  final String message;
  const CharacterError(this.message);
  @override
  List<Object> get props => [message];
}