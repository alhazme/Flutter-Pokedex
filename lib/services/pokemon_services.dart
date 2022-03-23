import 'dart:convert' as convert;
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:pokedex/models/pokemon_list_response.dart';
import 'package:pokedex/models/pokemon_detail_response.dart';

class PokemonService {
  final String baseURL = "pokeapi.co";

  String getBaseEndpoint(String endpoint) {
    return "/api/v2" + endpoint;
  }

  // Get pokemon list
  Future<PokemonListResponse> getPokemonList(
      {int offset = 0, int limit = 20}) async {
    var url = Uri.https(baseURL, getBaseEndpoint('/pokemon'),
        {'offset': offset.toString(), 'limit': limit.toString()});
    print(url.toString());
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var pokemonListResponse =
          PokemonListResponse.fromJson(convert.jsonDecode(response.body));
      return pokemonListResponse;
    } else {
      throw "Unable to retrieve pokemon list.";
    }
  }

  String getPokemonImageURL(String id) {
    return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/" +
        id +
        ".png";
  }

  Future<PokemonDetailResponse> getPokemonDetail(
      {String pokemonId = ""}) async {
    var url = Uri.https(baseURL, getBaseEndpoint('/pokemon/$pokemonId'));
    print(url.toString());
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var pokemonDetailResponse =
          PokemonDetailResponse.fromJson(convert.jsonDecode(response.body));
      return pokemonDetailResponse;
    } else {
      throw "Unable to retrieve pokemon detail.";
    }
  }
}
