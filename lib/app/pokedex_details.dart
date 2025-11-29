import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:helloworld/models/pokemon_model.dart';
import 'package:helloworld/models/pokemon_sprites.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PokedexDetails extends StatefulWidget {
  const PokedexDetails({super.key, required this.name});

  final String name;

  @override
  State<PokedexDetails> createState() => _PokedexDetailsState();
}

class _PokedexDetailsState extends State<PokedexDetails> {
  var client = http.Client();
  PokemonModel? _pokemonModel;

  Future<Map<String, dynamic>> callApi() async {
    final uri = Uri.parse('https://pokeapi.co/api/v2/pokemon/${widget.name}');

    try {
      final response = await client.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
        return decodedResponse;
      } else {
        throw Exception('Failed to load Pokemon: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error calling API: $e');
    }
  }

  // --- State Variables ---
  bool _isShiny = false;
  bool _isFront = true;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  // --- Logic ---
  String get currentSpriteUrl {
    final DefaultSpriteSet sprite = _pokemonModel!.sprites!.other!.showdown!;
    if (_isFront) {
      return _isShiny ? (sprite.backShiny ?? "") : (sprite.backDefault ?? "");
    } else {
      return _isShiny ? (sprite.frontShiny ?? "") : (sprite.frontDefault ?? "");
    }
  }

  Future<void> _playCry(String cryUrl) async {
    try {
      setState(() => _isPlaying = true);
      await _audioPlayer.play(UrlSource(cryUrl));
      // Reset icon after a short delay (approximate length of cry)
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) setState(() => _isPlaying = false);
    } catch (e) {
      debugPrint("Error playing audio: $e");
      if (mounted) setState(() => _isPlaying = false);
    }
  }

  @override
  void initState() {
    super.initState();
    callApi().then((value) {
      setState(() {
        _pokemonModel = PokemonModel.fromJson(value);
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _pokemonModel == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              title: Text(
                "${_pokemonModel!.name} #${_pokemonModel!.id.toString()}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.redAccent[700],
              foregroundColor: Colors.white,
              centerTitle: true,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // --- Screen / Sprite Area ---
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey[400]!, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(25),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Sprite Image
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CachedNetworkImage(
                              imageUrl: currentSpriteUrl,
                              fit: BoxFit.contain,
                              progressIndicatorBuilder:
                                  (context, child, loadingProgress) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                              errorWidget: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image,
                                      size: 50, color: Colors.grey),
                            ),
                          ),
                        ),
                        // Sprite Controls
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Rotate Button
                              IconButton.filledTonal(
                                onPressed: () =>
                                    setState(() => _isFront = !_isFront),
                                icon: const Icon(
                                  Icons.loop,
                                  color: Colors.black,
                                ),
                                tooltip: "Rotate View",
                              ),
                              const SizedBox(width: 16),
                              // Shiny Toggle
                              FilterChip(
                                label: const Text("Shiny ✨"),
                                selected: _isShiny,
                                onSelected: (val) =>
                                    setState(() => _isShiny = val),
                                selectedColor: Colors.deepPurple[200],
                                checkmarkColor: Colors.deepPurple[900],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // --- Info Section ---
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(25),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Types
                        Row(
                          children: _pokemonModel!.types!
                              .map((type) => Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.brown[
                                          300], // Normal type color approximation
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      type.type.name.toUpperCase(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                        const Divider(height: 30),

                        // Stats Grid
                        _buildStatRow(
                          "Weight",
                          _pokemonModel!.weight.toString() + " " + "Kilo",
                        ),
                        const SizedBox(height: 12),
                        _buildStatRow(
                          "Height",
                          _pokemonModel!.height.toString() + " " + "m",
                        ),
                        const SizedBox(height: 12),

                        /// This way you don't get to use index for referencing
                        // Column(
                        //   children: _pokemonModel!.abilities!
                        //       .map(
                        //         (e) => _buildStatRow(
                        //           "Ability",
                        //           e.ability.name,
                        //         ),
                        //       )
                        //       .toList(),
                        // ),
                        // But this is way you can
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: _pokemonModel!.abilities!.length,
                          itemBuilder: (context, i) {
                            final ability =
                                _pokemonModel!.abilities![i].ability;
                            return _buildStatRow(
                              "Ability #$i",
                              ability.name,
                            );
                          },
                        ),
                        const SizedBox(height: 12),

                        const Divider(height: 30),

                        // Audio Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton.icon(
                            onPressed: () =>
                                _playCry(_pokemonModel!.cries!.latest),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            icon: Icon(
                              _isPlaying ? Icons.volume_up : Icons.volume_mute,
                              color: Colors.white,
                            ),
                            label: Text(
                                _isPlaying ? "Playing Cry..." : "Play Cry"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Widget _buildStatRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
