import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'service_locator.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const CharacterPage(),
    ),
    GoRoute(
      path: '/character/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return BlocProvider(
          create: (_) => sl<CharacterDetailBloc>(),
          child: CharacterDetailPage(characterId: id),
        );
      },
    ),
  ],
);
