// ignore_for_file: use_super_parameters

import 'package:mpos_global_inc_test/src/domain/entitites/location.dart';

class LocationModel extends Location {
  const LocationModel({
    required String name,
    required String url,
  }) : super(name: name, url: url);

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}