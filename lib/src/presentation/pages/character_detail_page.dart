// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mpos_global_inc_test/src/presentation/bloc/character_detail_bloc/character_detail_bloc.dart';
import 'package:mpos_global_inc_test/src/presentation/bloc/character_detail_bloc/character_detail_event.dart';
import 'package:mpos_global_inc_test/src/presentation/bloc/character_detail_bloc/character_detail_state.dart';

class CharacterDetailPage extends StatefulWidget {
  final int characterId;

  const CharacterDetailPage({
    super.key,
    required this.characterId,
  });

  @override
  State<CharacterDetailPage> createState() => _CharacterDetailPageState();
}

class _CharacterDetailPageState  extends State<CharacterDetailPage> {

  @override
  void initState() {
    super.initState();

    // Esto evita errores de context
    Future.microtask(() {
      context.read<CharacterDetailBloc>().add(
         GetCharacterDetailEvent(widget.characterId),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CharacterDetailBloc,
          CharacterDetailState>(
        builder: (context, state) {
          if (state is CharacterDetailLoading || state is CharacterDetailInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CharacterDetailLoaded) {
            final character = state.character;
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                _buildSliverAppBar(character),
                _buildContent(character),
              ],
            );
          }

          if (state is CharacterDetailError) {
            return Center(
              child: Text(state.message),
            );
          }

          return const Center(
            child: Text('Something went wrong!'),
          );
        },
      ),
    );
  }




  // =========================
  // 🔥 HEADER
  // =========================

  Widget _buildSliverAppBar(character) {
    return SliverAppBar(
      expandedHeight: 350,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.black,
      elevation: 0,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final top = constraints.biggest.height;
          final isCollapsed =
              top <= kToolbarHeight + 20;

          return FlexibleSpaceBar(
            centerTitle: true,
            title: AnimatedOpacity(
              duration: const Duration(
                milliseconds: 200,
              ),
              opacity: isCollapsed ? 1 : 0,
              child: Text(
                character.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            background: Stack(
              fit: StackFit.expand,
              children: [
                Hero(
                  tag: character.id,
                  child: Image.network(
                    character.image,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.8),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 20,
                  right: 20,
                  child: AnimatedOpacity(
                    duration: const Duration(
                      milliseconds: 300,
                    ),
                    opacity: isCollapsed ? 0 : 1,
                    child: Text(
                      character.name,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      leading: Padding(
         padding: const EdgeInsets.all(8.0),
         child: GestureDetector(
           onTap: () => Navigator.pop(context),
           child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.25),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
             ),
           ),
         ),
      ),
    );
  }


  // =========================
  // 📦 CONTENIDO
  // =========================

  Widget _buildContent(character) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                _buildBadge(
                  character.status,
                  _getStatusColor(
                      character.status),
                ),
                const SizedBox(width: 10),
                _buildBadge(
                  character.species,
                  Colors.blueAccent,
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildInfoCard([
              _buildItem(
                  "Gender", character.gender),
              _buildItem(
                "Origin",
                character.origin?.name ??
                    'Unknown',
              ),
              _buildItem(
                "Location",
                character.location?.name ??
                    'Unknown',
              ),
            ]),
          ],
        ),
      ),
    );
  }



  // =========================
  // 🏷️ UI COMPONENTS
  // =========================

  Widget _buildBadge(
      String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoCard(
      List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildItem(
      String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 10),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Expanded(
            flex: 2,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }



  // =========================
  // 🎨 HELPERS
  // =========================

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
}