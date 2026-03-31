import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mpos_global_inc_test/src/data/datasources/charater_remote_data_source.dart';
import 'package:mpos_global_inc_test/src/data/repositories/character_repository_impl.dart';
import 'package:mpos_global_inc_test/src/domain/repositories/character_repository.dart';
import 'package:mpos_global_inc_test/src/domain/usecases/get_all_characters.dart';
import 'package:mpos_global_inc_test/src/domain/usecases/get_character_by_id.dart';
import 'package:mpos_global_inc_test/src/domain/usecases/search_characters.dart';


final sl = GetIt.instance;

void init() {
  /*
  // Blocs
  sl.registerFactory(() => CharacterBloc(sl(), sl()));
  sl.registerFactory(() => CharacterDetailBloc(sl()));
*/
  // Usecases
  sl.registerLazySingleton(() => GetAllCharacters(sl()));
  sl.registerLazySingleton(() => GetCharacterById(sl()));
  sl.registerLazySingleton(() => SearchCharacters(sl()));

  // Repositories
  sl.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImpl(remoteDataSource: sl()),
  );

  // Datasources
  sl.registerLazySingleton<CharacterRemoteDataSource>(
    () => CharacterRemoteDataSourceImpl(dio: sl()),
  );

  // External
  sl.registerLazySingleton(() => Dio());
}
