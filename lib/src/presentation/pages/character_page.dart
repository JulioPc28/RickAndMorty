// ignore_for_file: unnecessary_string_interpolations, deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mpos_global_inc_test/src/presentation/bloc/character_bloc.dart';
import 'package:mpos_global_inc_test/src/presentation/bloc/character_event.dart';
import 'package:mpos_global_inc_test/src/presentation/bloc/character_state.dart';


class CharacterPage extends StatefulWidget {
  const CharacterPage({super.key});

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    context.read<CharacterBloc>().add(GetCharactersEvent());
    _scrollController.addListener(_onScroll);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Container(
                height: 45,
                decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
            child: TextField(
               controller: _searchController,
               decoration: const InputDecoration(
                 hintText: 'Buscar personaje...',
                 prefixIcon: Icon(Icons.search),
                 border: InputBorder.none,
               ),
           ),
        ),
      ),
        body: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
          if (state is CharacterInitial || (state is CharacterLoading && state is! CharacterLoaded)) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CharacterLoaded) {
            if (state.characters.isEmpty) {
              return const Center(child: Text('No characters found.'));
            }
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              controller: _scrollController,
              itemCount: state.hasReachedMax ? state.characters.length : state.characters.length + 1,
              itemBuilder: (context, index) {
                if (index >= state.characters.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                final character = state.characters[index];
                return  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(16),
                       color: Colors.white,
                         boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                         ],
                    ),
                    child: InkWell(
                       borderRadius: BorderRadius.circular(16),
                       onTap: () {
                          context.push('/character/${character.id}');
                       },
                       child: Row(
                          children: [
                            Hero(
                              tag: character.id,
                              child: ClipRRect(
                                   borderRadius: const BorderRadius.only(
                                   topLeft: Radius.circular(16),
                                   bottomLeft: Radius.circular(16),
                                   ),
                                   child: Image.network(character.image,
                                   width: 110,
                                   height: 110,
                                   fit: BoxFit.cover,
                                   ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                               child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                          Text(character.name,
                                           style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                           ),
                                        ),
                                          const SizedBox(height: 6),
                                          Container(
                                           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                               color: _getStatusColor(character.status).withOpacity(0.2),
                                                borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Text(character.status,
                                             style: TextStyle(
                                                 color: _getStatusColor(character.status),
                                                 fontWeight: FontWeight.w600,
                                             ),
                                           ),
                                           ),
                                          const SizedBox(height: 6),
                                          Text(character.species,
                                             style: TextStyle(
                                               color: Colors.grey.shade600,
                                              ),
                                          ),
                                     ],
                                   ),
                               ),
                            ),
                          ],
                       ),
                      ),
                  );
              },
            );
          } else if (state is CharacterError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Something went wrong!'));
          }
        },
      ),
    );
  }

Color _getStatusColor(String status) {
  switch (status) {
    case 'Alive':
      return Colors.green;
    case 'Dead':
      return Colors.red;
    default:
      return Colors.grey;
  }
}

  void _onScroll() {
    if (_isBottom) {
      context.read<CharacterBloc>().add(GetCharactersEvent());
    }
  }


  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (_searchController.text.isNotEmpty) {
        context.read<CharacterBloc>().add(SearchCharactersEvent(_searchController.text));
      } else {
        context.read<CharacterBloc>().add(ClearSearchEvent());
      }
    });
  }


  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }



  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}
