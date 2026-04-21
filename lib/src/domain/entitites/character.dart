// ignore_for_file: depend_on_referenced_packages
import 'package:equatable/equatable.dart';
import 'package:mpos_global_inc_test/src/domain/entitites/location.dart';

/// Entidad del dominio que representa un personaje.
/// Define qué información tiene un personaje dentro del negocio,
/// sin depender de API, JSON o librerías externas.
class Character extends Equatable {
  final int id;              /// Identificador del personaje
  final String name;         /// Nombre del personaje
  final String status;       /// Estado (Alive, Dead, etc.)
  final String species;      /// Especie del personaje
  final String gender;       /// Género del personaje
  final String image;        /// URL de la imagen
  final Location origin;     /// Lugar de origen
  final Location location;   /// Ubicación actual

  /// Constructor de la entidad.
  /// Todas las propiedades son obligatorias porque la entidad
  /// representa un objeto completo del dominio.
  /// 
  const Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
    required this.origin,
    required this.location,
  });

  /// Define cómo se compara un Character con otro.
  /// Dos personajes son iguales si todas estas propiedades son iguales.
  @override
  List<Object?> get props => [id, name, status, species, gender, image, origin, location];
}
