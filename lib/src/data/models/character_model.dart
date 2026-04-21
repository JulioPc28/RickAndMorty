// Modelo de datos usado para mapear la información que viene de la API.
// Vive en la capa de data y extiende la entidad del dominio.
// ignore_for_file: use_super_parameters

import 'package:mpos_global_inc_test/src/data/models/location_model.dart';
import 'package:mpos_global_inc_test/src/domain/entitites/character.dart';

class CharacterModel extends Character {
  /// Constructor del modelo.
  /// Recibe los datos y los pasa a la entidad base (Character).
  const CharacterModel({
    required int id,
    required String name,
    required String status,
    required String species,
    required String gender,
    required String image,
    required LocationModel origin,
    required LocationModel location,
  }) : super(
          id: id,
          name: name,
          status: status,
          species: species,
          gender: gender,
          image: image,
          origin: origin,
          location: location,
        );

  /// Crea un CharacterModel a partir de un JSON proveniente de la API
  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      status: json['status'] ?? '',
      species: json['species'] ?? '',
      gender: json['gender'] ?? '',
      image: json['image'] ?? '',
      origin: LocationModel.fromJson(json['origin'] ?? {}),
      location: LocationModel.fromJson(json['location'] ?? {}),
    );
  }

  /// Convierte el modelo nuevamente a JSON.
  /// Se usa si se necesita enviar datos o guardar información.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'gender': gender,
      'image': image,
      'origin': (origin as LocationModel).toJson(),
      'location': (location as LocationModel).toJson(),
    };
  }
}
