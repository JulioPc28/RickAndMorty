// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mpos_global_inc_test/src/domain/usecases/get_character_by_id.dart';
import 'package:mpos_global_inc_test/src/presentation/bloc/character_detail_bloc/character_detail_event.dart';
import 'package:mpos_global_inc_test/src/presentation/bloc/character_detail_bloc/character_detail_state.dart';

/// Bloc encargado de manejar el detalle de un personaje.
/// Coordina la carga del detalle y los estados de la UI.
class CharacterDetailBloc extends Bloc<CharacterDetailEvent, CharacterDetailState> {

  final GetCharacterById getCharacterById;
  /// Se recibe el caso de uso por inyección de dependencias
  CharacterDetailBloc(this.getCharacterById)

   : super(CharacterDetailInitial()) {

    /// Manejo del evento para cargar el detalle del personaje
    on<GetCharacterDetailEvent>((event, emit) async {
      /// Se emite estado de carga
      emit(CharacterDetailLoading());

      /// Se ejecuta el caso de uso con el id recibido
      final result = await getCharacterById(CharacterByIdParams(id: event.id),);

      /// Se maneja el resultado (éxito o error)
      result.fold(
        (failure) => emit(CharacterDetailError(failure.message)),
        (character) => emit(CharacterDetailLoaded(character)),
      );
    });
  }
}
