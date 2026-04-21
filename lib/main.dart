// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mpos_global_inc_test/src/presentation/bloc/character_bloc.dart';
import 'src/core/service_locator.dart' as di;
import 'src/core/router.dart';

void main() {
  /// Se inicializan todas las dependencias (use cases, blocs, repositorios, etc.)
  di.init();
  /// Se ejecuta la aplicación
  runApp(const MyApp());
}

/// Widget raíz de la aplicación
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// Inyección global de Blocs para toda la aplicación
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<CharacterBloc>(),
        ),
        // El Bloc de detalle se inyecta por ruta, no globalmente
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Rick and Morty',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        /// Configuración de navegación usando GoRouter
        routerConfig: router,
      ),
    );
  }
}