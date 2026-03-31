


import 'package:equatable/equatable.dart';

abstract class CharacterEvent extends Equatable {
  const CharacterEvent();

  @override
  List<Object> get props => [];
}

class GetCharactersEvent extends CharacterEvent {}

class SearchCharactersEvent extends CharacterEvent {
  final String query;

  const SearchCharactersEvent(this.query);

  @override
  List<Object> get props => [query];
}

class ClearSearchEvent extends CharacterEvent {}
