import 'package:helloworld/models/pokemon_ability.dart';
import 'package:helloworld/models/pokemon_cry.dart';
import 'package:helloworld/models/pokemon_sprites.dart';
import 'package:helloworld/models/pokemon_stats.dart';
import 'package:helloworld/models/pokemon_types.dart';

class PokemonModel {
  int? id;
  String? name;
  int? order;
  int? baseExperience;
  int? height;
  int? weight;
  List<PokemonAbility>? abilities;
  PokemonCry? cries;
  List<PokemonType>? types;
  List<PokemonStat>? stats;
  PokemonSprites? sprites;

  PokemonModel({
    this.id,
    this.name,
    this.order,
    this.baseExperience,
    this.height,
    this.weight,
    this.abilities,
    this.cries,
    this.types,
    this.stats,
    this.sprites,
  });

  PokemonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    order = json['order'];
    baseExperience = json['base_experience'];
    height = json['height'];
    weight = json['weight'];

    // --- Single Object Fields ---
    if (json['cries'] != null) {
      cries = PokemonCry.fromJson(json['cries']);
    }
    if (json['sprites'] != null) {
      sprites = PokemonSprites.fromJson(json['sprites']);
    }

    // --- List Fields (Abilities) ---
    if (json['abilities'] != null) {
      abilities = <PokemonAbility>[];
      json['abilities'].forEach((v) {
        // Assume PokemonAbility has a factory/generative .fromJson method
        abilities!.add(PokemonAbility.fromJson(v));
      });
    }

    // --- List Fields (Types) ---
    if (json['types'] != null) {
      types = <PokemonType>[];
      json['types'].forEach((v) {
        // Assume PokemonType has a factory/generative .fromJson method
        types!.add(PokemonType.fromJson(v));
      });
    }

    // --- List Fields (Stats) ---
    if (json['stats'] != null) {
      stats = <PokemonStat>[];
      json['stats'].forEach((v) {
        // Assume PokemonStat has a factory/generative .fromJson method
        stats!.add(PokemonStat.fromJson(v));
      });
    }
  }
}
