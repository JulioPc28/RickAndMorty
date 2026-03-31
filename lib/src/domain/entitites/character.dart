import 'package:equatable/equatable.dart';
import 'package:mpos_global_inc_test/src/domain/entitites/location.dart';

class Character extends Equatable {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String image;
  final Location origin;
  final Location location;

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

  @override
  List<Object?> get props => [id, name, status, species, gender, image, origin, location];
}
