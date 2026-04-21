// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mpos_global_inc_test/src/data/datasources/character_remote_data_source.dart';
import 'package:mpos_global_inc_test/src/data/repositories/character_repository_impl.dart';
import 'package:mpos_global_inc_test/src/domain/repositories/character_repository.dart';
import 'package:mpos_global_inc_test/src/domain/usecases/get_all_characters.dart';
import 'package:mpos_global_inc_test/src/domain/usecases/get_character_by_id.dart';
import 'package:mpos_global_inc_test/src/domain/usecases/search_characters.dart';
import 'package:mpos_global_inc_test/src/presentation/bloc/character_bloc.dart';
import 'package:mpos_global_inc_test/src/presentation/bloc/character_detail_bloc/character_detail_bloc.dart';

/// Instancia global de GetIt para inyección de dependencias.
/// Aquí se registran todas las clases que la app necesita.
final sl = GetIt.instance;

/// Método que inicializa todas las dependencias del proyecto
void init() {

  // ===== BLOCS =====
  // Se crean nuevos bloques cada vez que se solicitan
  sl.registerFactory(() => CharacterBloc(sl(), sl()));
  sl.registerFactory(() => CharacterDetailBloc(sl()));

  // ===== USE CASES =====
  // Contienen la lógica de negocio de la aplicación
  sl.registerLazySingleton(() => GetAllCharacters(sl()));
  sl.registerLazySingleton(() => GetCharacterById(sl()));
  sl.registerLazySingleton(() => SearchCharacters(sl()));

  // ===== REPOSITORY =====
  // Implementación concreta del repositorio del dominio
  sl.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImpl(remoteDataSource: sl()),
  );

  // ===== DATA SOURCE =====
  // Se encarga de consumir la API externa
  sl.registerLazySingleton<CharacterRemoteDataSource>(
    () => CharacterRemoteDataSourceImpl(dio: sl()),
  );

  // ===== EXTERNAL =====
  // Dependencias externas como el cliente HTTP
  sl.registerLazySingleton(() => Dio());
}