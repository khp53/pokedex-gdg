import 'package:flutter/material.dart';
import 'package:helloworld/app/pokedex_details.dart';
import 'package:helloworld/models/pokemon_list.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var client = http.Client();

  Future<PokemonList> callApi() async {
    final uri =
        Uri.parse('https://pokeapi.co/api/v2/pokemon?offset=0&limit=50');

    try {
      final response = await client.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
        return PokemonList.fromJson(decodedResponse);
      } else {
        throw Exception('Failed to load Pokemon: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error calling API: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.redAccent[700],
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: FutureBuilder<PokemonList>(
        future: callApi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final data = snapshot.data!;

            return ListView.separated(
              itemCount: data.results!.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                var pokemon = data.results;
                return ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PokedexDetails(
                        name: pokemon![index].name ?? "pikachu",
                      ),
                    ),
                  ),
                  title: Text(
                    data.results![index].name!.toUpperCase(),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}
