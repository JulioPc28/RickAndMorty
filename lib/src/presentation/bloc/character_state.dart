
import 'package:equatable/equatable.dart';
import 'package:mpos_global_inc_test/src/domain/entitites/character.dart';

abstract class CharacterState extends Equatable {
  const CharacterState();

  @override
  List<Object> get props => [];
}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {
  final List<Character> characters;

  const CharacterLoading({this.characters = const []});

  @override
  List<Object> get props => [characters];
}

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

class CharacterError extends CharacterState {
  final String message;

  const CharacterError(this.message);

  @override
  List<Object> get props => [message];
}
