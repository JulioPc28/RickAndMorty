// ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mpos_global_inc_test/src/presentation/bloc/character_bloc.dart';
import 'package:mpos_global_inc_test/src/presentation/bloc/character_detail_bloc/character_detail_bloc.dart';
import 'src/core/service_locator.dart' as di;
import 'src/core/router.dart'; 

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<CharacterBloc>()),
        // BlocProvider(create: (_) => di.sl<CharacterDetailBloc>()),
      ],
      child: MaterialApp.router( 
        debugShowCheckedModeBanner: false,
        title: 'Rick and Morty',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: router, 
      ),
    );
  }
}