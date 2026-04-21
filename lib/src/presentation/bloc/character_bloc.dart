// ignore_for_file: depend_on_referenced_packages

import 'package:mpos_global_inc_test/src/domain/usecases/get_all_characters.dart';
import 'package:mpos_global_inc_test/src/domain/usecases/search_characters.dart';
import 'package:mpos_global_inc_test/src/presentation/bloc/character_event.dart';
import 'package:mpos_global_inc_test/src/presentation/bloc/character_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Bloc encargado de manejar el listado de personajes,
/// la paginación y la búsqueda.
class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final GetAllCharacters getAllCharacters;
  final SearchCharacters searchCharacters;

  /// El Bloc recibe los casos de uso por inyección de dependencias
  CharacterBloc(this.getAllCharacters, this.searchCharacters)
      : super(CharacterInitial()) {

    /// Evento para cargar personajes con paginación
    on<GetCharactersEvent>(_onGetCharacters, transformer: throttleDroppable( const Duration(milliseconds: 500),  ), );

    /// Evento para buscar personajes
    on<SearchCharactersEvent>(_onSearchCharacters);

    /// Evento para limpiar la búsqueda
    on<ClearSearchEvent>(_onClearSearch);
  }




  /// Maneja la carga de personajes (paginación)
  Future<void> _onGetCharacters(GetCharactersEvent event, Emitter<CharacterState> emit) async {
    final currentState = state;
    /// Si ya se llegó al final, no se hace otra petición
    if (currentState is CharacterLoaded && currentState.hasReachedMax) return;
    /// Muestra loading manteniendo personajes ya cargados
    emit(
      CharacterLoading(
        characters: currentState is CharacterLoaded ? currentState.characters : [],
      ),
    );
    /// Ejecuta el caso de uso con el número de página
    final result = await getAllCharacters(
      Params(
        page: currentState is CharacterLoaded
            ? currentState.pageNumber + 1
            : 1,
      ),
    );



    /// Maneja éxito o error
    result.fold(
      (failure) => emit(CharacterError(failure.message)),
      (characters) {
        if (currentState is CharacterLoaded) {
          /// Se concatenan los nuevos personajes
          emit(
            CharacterLoaded(
              characters: currentState.characters + characters,
              pageNumber: currentState.pageNumber + 1,
              hasReachedMax: characters.isEmpty,
            ),
          );
        } else {
          /// Primera carga
          emit(
            CharacterLoaded(
              characters: characters,
              pageNumber: 1,
            ),
          );
        }
      },
    );
  }



  /// Maneja la búsqueda de personajes
  Future<void> _onSearchCharacters(
      SearchCharactersEvent event,
      Emitter<CharacterState> emit) async {

    emit(CharacterLoading());

    final result = await searchCharacters(
      SearchCharactersParams(query: event.query),
    );

    result.fold(
      (failure) => emit(CharacterError(failure.message)),
      (characters) => emit(
        CharacterLoaded(
          characters: characters,
          hasReachedMax: true,
        ),
      ),
    );
  }

  /// Limpia la búsqueda y recarga el listado inicial
  void _onClearSearch(
      ClearSearchEvent event,
      Emitter<CharacterState> emit) {

    emit(CharacterInitial());
    add(GetCharactersEvent());
  }
}

/// Previene muchas peticiones seguidas (scroll rápido)
EventTransformer<T> throttleDroppable<T>(Duration duration) {
  return (events, mapper) {
    return events
        .throttleTime(
          duration,
          leading: true,
          trailing: false,
        )
        .switchMap(mapper);
  };
}