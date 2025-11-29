class PokemonCry {
  final String latest;
  final String legacy;

  PokemonCry({
    required this.latest,
    required this.legacy,
  });

  /// Factory constructor to create a PokemonCry instance from a JSON map.
  factory PokemonCry.fromJson(Map<String, dynamic> json) {
    return PokemonCry(
      latest: json['latest'] ?? '',
      legacy: json['legacy'] ?? '',
    );
  }

  /// Method to convert the PokemonCry instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'latest': latest,
      'legacy': legacy,
    };
  }
}
