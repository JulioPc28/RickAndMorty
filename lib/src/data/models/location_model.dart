// Modelo de datos para la ubicación del personaje.
// Se encarga de convertir los datos que vienen de la API
// a un objeto usable por la aplicación.
// ignore_for_file: use_super_parameters

import 'package:mpos_global_inc_test/src/domain/entitites/location.dart';

class LocationModel extends Location {
  /// Constructor del modelo.
  /// Recibe los valores y los pasa a la entidad Location.
  const LocationModel({
    required String name,
    required String url,
  }) : super(name: name, url: url);

  /// Crea una ubicación a partir de un JSON de la API
  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['name'] ?? '',
      url: json['url'] ?? '',
    );
  }

  /// Convierte la ubicación a formato JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}