
import 'package:mpos_global_inc_test/src/domain/usecases/get_all_characters.dart';
import 'package:mpos_global_inc_test/src/domain/usecases/search_characters.dart';
import 'package:mpos_global_inc_test/src/presentation/bloc/character_event.dart';
import 'package:mpos_global_inc_test/src/presentation/bloc/character_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final GetAllCharacters getAllCharacters;
  final SearchCharacters searchCharacters;

  CharacterBloc(this.getAllCharacters, this.searchCharacters) : super(CharacterInitial()) {
    on<GetCharactersEvent>(
      _onGetCharacters,
      transformer: throttleDroppable(const Duration(milliseconds: 500)),
    );
    on<SearchCharactersEvent>(_onSearchCharacters);
    on<ClearSearchEvent>(_onClearSearch);
  }

  Future<void> _onGetCharacters(GetCharactersEvent event, Emitter<CharacterState> emit) async {
    final currentState = state;
    if (currentState is CharacterLoaded && currentState.hasReachedMax) return;

    emit(CharacterLoading(characters: currentState is CharacterLoaded ? currentState.characters : []));

    final result = await getAllCharacters(Params(page: currentState is CharacterLoaded ? currentState.pageNumber + 1 : 1));

    result.fold(
      (failure) => emit(CharacterError(failure.message)),
      (characters) {
        if (currentState is CharacterLoaded) {
          emit(CharacterLoaded(
            characters: currentState.characters + characters,
            pageNumber: currentState.pageNumber + 1,
            hasReachedMax: characters.isEmpty,
          ));
        } else {
          emit(CharacterLoaded(characters: characters, pageNumber: 1));
        }
      },
    );
  }

  Future<void> _onSearchCharacters(SearchCharactersEvent event, Emitter<CharacterState> emit) async {
    emit(CharacterLoading());

    final result = await searchCharacters(SearchCharactersParams(query: event.query));

    result.fold(
      (failure) => emit(CharacterError(failure.message)),
      (characters) => emit(CharacterLoaded(characters: characters, hasReachedMax: true)),
    );
  }

  void _onClearSearch(ClearSearchEvent event, Emitter<CharacterState> emit) {
    emit(CharacterInitial());
    add(GetCharactersEvent());
  }
}

EventTransformer<T> throttleDroppable<T>(Duration duration) {
  return (events, mapper) {
    return events.throttleTime(duration, leading: true, trailing: false).switchMap(mapper);
  };
}
