import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mpos_global_inc_test/src/presentation/bloc/character_detail_bloc/character_detail_bloc.dart';
import 'package:mpos_global_inc_test/src/presentation/pages/character_detail_page.dart';
import 'package:mpos_global_inc_test/src/presentation/pages/character_page.dart';
import 'service_locator.dart';

/// Configuración central de las rutas de la aplicación.
/// Aquí se define la navegación usando GoRouter.
final router = GoRouter(
  /// Ruta inicial de la app
  initialLocation: '/',

  routes: [
    /// Ruta principal que muestra la lista de personajes
    GoRoute(
      path: '/',
      builder: (context, state) => const CharacterPage(),
    ),

    /// Ruta para el detalle de un personaje
    /// Recibe el id del personaje como parámetro
    GoRoute(
      path: '/character/:id',
      builder: (context, state) {
        /// Se obtiene el parámetro id desde la ruta
        final idParam = state.pathParameters['id'];

        /// Se convierte el id a entero
        final id = int.tryParse(idParam ?? '');

        /// Si el id no es válido, se regresa a la pantalla principal
        if (id == null) {
          return const CharacterPage();
        }

        /// Se inyecta el BLoC del detalle usando el service locator
        /// para mantener la separación de responsabilidades
        return BlocProvider(
          create: (_) => sl<CharacterDetailBloc>(),
          child: CharacterDetailPage(characterId: id),
        );
      },
    ),
  ],
);
