class PokemonStat {
  final int baseStat;
  final int effort;
  final StatDetail stat;

  PokemonStat({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  /// Factory constructor to create a PokemonStat instance from a JSON map.
  factory PokemonStat.fromJson(Map<String, dynamic> json) {
    return PokemonStat(
      baseStat: json['base_stat'] ?? 0,
      effort: json['effort'] ?? 0,
      stat: StatDetail.fromJson(json['stat']),
    );
  }

  /// Method to convert the PokemonStat instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'base_stat': baseStat,
      'effort': effort,
      'stat': stat.toJson(),
    };
  }
}

class StatDetail {
  final String name;
  final String url;

  StatDetail({
    required this.name,
    required this.url,
  });

  /// Factory constructor to create a StatDetail instance from a JSON map.
  factory StatDetail.fromJson(Map<String, dynamic> json) {
    return StatDetail(
      name: json['name'] ?? '',
      url: json['url'] ?? '',
    );
  }

  /// Method to convert the StatDetail instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}
