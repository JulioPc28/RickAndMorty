// ignore_for_file: depend_on_referenced_packages
import 'package:equatable/equatable.dart';

/// Entidad del dominio que representa una ubicación.
/// Define qué es una ubicación dentro del negocio,
/// sin depender de API, JSON o implementación técnica.
class Location extends Equatable {
 
  final String name;    /// Nombre de la ubicación
  final String url;    /// URL asociada a la ubicación

  /// Constructor de la entidad Location.
  /// Todas las propiedades son obligatorias porque
  /// representan información básica del dominio.
  const Location({
    required this.name,
    required this.url,
  });

  /// Define cómo se compara un Location con otro.
  /// Dos ubicaciones son iguales si tienen el mismo nombre y url.
  @override
  List<Object?> get props => [name, url];
}
