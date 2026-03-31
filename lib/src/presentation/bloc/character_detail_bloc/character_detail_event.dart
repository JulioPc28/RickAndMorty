
import 'package:equatable/equatable.dart';

abstract class CharacterDetailEvent extends Equatable {
  const CharacterDetailEvent();

  @override
  List<Object> get props => [];
}

class GetCharacterDetailEvent extends CharacterDetailEvent {
  final int id;

  const GetCharacterDetailEvent(this.id);

  @override
  List<Object> get props => [id];
}
