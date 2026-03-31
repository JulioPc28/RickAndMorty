


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mpos_global_inc_test/src/domain/usecases/get_character_by_id.dart';
import 'package:mpos_global_inc_test/src/presentation/bloc/character_detail_bloc/character_detail_event.dart';
import 'package:mpos_global_inc_test/src/presentation/bloc/character_detail_bloc/character_detail_state.dart';

class CharacterDetailBloc extends Bloc<CharacterDetailEvent, CharacterDetailState> {
  final GetCharacterById getCharacterById;

  CharacterDetailBloc(this.getCharacterById) : super(CharacterDetailInitial()) {
    on<GetCharacterDetailEvent>((event, emit) async {
      emit(CharacterDetailLoading());
      final result = await getCharacterById(CharacterByIdParams(id: event.id));
      result.fold(
        (failure) => emit(CharacterDetailError(failure.message)),
        (character) => emit(CharacterDetailLoaded(character)),
      );
    });
  }
}
