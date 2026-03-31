import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mpos_global_inc_test/src/presentation/bloc/character_detail_bloc/character_detail_bloc.dart';
import 'package:mpos_global_inc_test/src/presentation/pages/character_detail_page.dart';
import 'package:mpos_global_inc_test/src/presentation/pages/character_page.dart';
import 'service_locator.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const CharacterPage(),
    ),

    GoRoute(
      path: '/character/:id',
      builder: (context, state) {
        final idParam = state.pathParameters['id'];
        final id = int.tryParse(idParam ?? '');

        if (id == null) {
          return const CharacterPage();
        }

        return BlocProvider(
          create: (_) => sl<CharacterDetailBloc>(),
          child: CharacterDetailPage(characterId: id),
        );
      },
    ),
  ],
);