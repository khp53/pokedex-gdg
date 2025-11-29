class PokemonSprites {
  final String? backDefault;
  final String? backFemale;
  final String? backShiny;
  final String? backShinyFemale;
  final String? frontDefault;
  final String? frontFemale;
  final String? frontShiny;
  final String? frontShinyFemale;
  final OtherSprites? other;

  PokemonSprites({
    this.backDefault,
    this.backFemale,
    this.backShiny,
    this.backShinyFemale,
    this.frontDefault,
    this.frontFemale,
    this.frontShiny,
    this.frontShinyFemale,
    this.other,
  });

  factory PokemonSprites.fromJson(Map<String, dynamic> json) {
    return PokemonSprites(
      backDefault: json['back_default'],
      backFemale: json['back_female'],
      backShiny: json['back_shiny'],
      backShinyFemale: json['back_shiny_female'],
      frontDefault: json['front_default'],
      frontFemale: json['front_female'],
      frontShiny: json['front_shiny'],
      frontShinyFemale: json['front_shiny_female'],
      other:
          json['other'] != null ? OtherSprites.fromJson(json['other']) : null,
    );
  }
}

// A simple utility class for sprites that only have default/female/shiny/etc.
// Used for nested sprite sets like 'home' or 'red-blue'.
class DefaultSpriteSet {
  final String? frontDefault;
  final String? frontFemale;
  final String? frontShiny;
  final String? frontShinyFemale;
  final String? backDefault;
  final String? backFemale;
  final String? backShiny;
  final String? backShinyFemale;

  DefaultSpriteSet({
    this.frontDefault,
    this.frontFemale,
    this.frontShiny,
    this.frontShinyFemale,
    this.backDefault,
    this.backFemale,
    this.backShiny,
    this.backShinyFemale,
  });

  factory DefaultSpriteSet.fromJson(Map<String, dynamic> json) {
    return DefaultSpriteSet(
      frontDefault: json['front_default'],
      frontFemale: json['front_female'],
      frontShiny: json['front_shiny'],
      frontShinyFemale: json['front_shiny_female'],
      backDefault: json['back_default'],
      backFemale: json['back_female'],
      backShiny: json['back_shiny'],
      backShinyFemale: json['back_shiny_female'],
    );
  }
}

// --- 2. 'other' Sprites Model ---

class OtherSprites {
  final DreamWorldSprites? dreamWorld;
  final DefaultSpriteSet? home;
  final OfficialArtworkSprites? officialArtwork;
  final DefaultSpriteSet? showdown;

  OtherSprites({
    this.dreamWorld,
    this.home,
    this.officialArtwork,
    this.showdown,
  });

  factory OtherSprites.fromJson(Map<String, dynamic> json) {
    return OtherSprites(
      // Note: Using the simple DefaultSpriteSet for 'home' and 'showdown'
      dreamWorld: json['dream_world'] != null
          ? DreamWorldSprites.fromJson(json['dream_world'])
          : null,
      home:
          json['home'] != null ? DefaultSpriteSet.fromJson(json['home']) : null,
      officialArtwork: json['official-artwork'] != null
          ? OfficialArtworkSprites.fromJson(json['official-artwork'])
          : null,
      showdown: json['showdown'] != null
          ? DefaultSpriteSet.fromJson(json['showdown'])
          : null,
    );
  }
}

class DreamWorldSprites {
  final String? frontDefault;
  final String? frontFemale;

  DreamWorldSprites({this.frontDefault, this.frontFemale});

  factory DreamWorldSprites.fromJson(Map<String, dynamic> json) {
    return DreamWorldSprites(
      frontDefault: json['front_default'],
      frontFemale: json['front_female'],
    );
  }
}

class OfficialArtworkSprites {
  final String? frontDefault;
  final String? frontShiny;

  OfficialArtworkSprites({this.frontDefault, this.frontShiny});

  factory OfficialArtworkSprites.fromJson(Map<String, dynamic> json) {
    return OfficialArtworkSprites(
      frontDefault: json['front_default'],
      frontShiny: json['front_shiny'],
    );
  }
}
