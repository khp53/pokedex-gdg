class PokemonType {
  final int slot;
  final TypeDetail type;

  PokemonType({
    required this.slot,
    required this.type,
  });

  /// Factory constructor to create a PokemonType instance from a JSON map.
  factory PokemonType.fromJson(Map<String, dynamic> json) {
    return PokemonType(
      slot: json['slot'] ?? 0,
      type: TypeDetail.fromJson(json['type']),
    );
  }

  /// Method to convert the PokemonType instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'slot': slot,
      'type': type.toJson(),
    };
  }
}

class TypeDetail {
  final String name;
  final String url;

  TypeDetail({
    required this.name,
    required this.url,
  });

  /// Factory constructor to create a TypeDetail instance from a JSON map.
  factory TypeDetail.fromJson(Map<String, dynamic> json) {
    return TypeDetail(
      name: json['name'] ?? '',
      url: json['url'] ?? '',
    );
  }

  /// Method to convert the TypeDetail instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}
