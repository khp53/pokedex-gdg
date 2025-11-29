// A factory constructor in Dart is a special type of constructor used when you don't want to create a new instance of the class every time the constructor is called. Instead of guaranteeing the creation of a fresh object, it has the flexibility to:
// Return an existing instance from a cache.
// Return an instance of a subtype (a subclass).
// Perform complex initialization logic that traditional generative constructors can't handle.
class PokemonAbility {
  final AbilityDetail ability;
  final bool isHidden;
  final int slot;

  PokemonAbility({
    required this.ability,
    required this.isHidden,
    required this.slot,
  });

  // Factory constructor for creating a new PokemonAbility instance from a map.
  factory PokemonAbility.fromJson(Map<String, dynamic> json) {
    return PokemonAbility(
      ability: AbilityDetail.fromJson(json['ability']),
      isHidden: json['is_hidden'] ?? false,
      slot: json['slot'] ?? 0,
    );
  }

  // Method to convert PokemonAbility instance to a map.
  Map<String, dynamic> toJson() {
    return {
      'ability': ability.toJson(),
      'is_hidden': isHidden,
      'slot': slot,
    };
  }
}

class AbilityDetail {
  final String name;
  final String url;

  AbilityDetail({
    required this.name,
    required this.url,
  });

  factory AbilityDetail.fromJson(Map<String, dynamic> json) {
    return AbilityDetail(
      name: json['name'] ?? '',
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}
