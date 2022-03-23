import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pokedex/extensions/string_extensions.dart';
import 'package:pokedex/screens/detail_page_arguments.dart';
import 'package:pokedex/services/pokemon_services.dart';
import 'package:pokedex/models/pokemon_detail_response.dart';

class DetailPokemonPage extends StatefulWidget {
  const DetailPokemonPage({Key? key}) : super(key: key);

  static const routeName = '/pokemonDetail';

  @override
  State<DetailPokemonPage> createState() => _DetailPokemonPageState();
}

class _DetailPokemonPageState extends State<DetailPokemonPage> {
  PokemonService pokemonService = PokemonService();

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as DetailPageArguments;

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(args.pokemonName),
      ),
      body: Container(
        child: Row(
          children: [
            Column(
              children: [
                Stack(
                  children: <Widget>[
                    Container(
                      width: (MediaQuery.of(context).size.width),
                      height: (MediaQuery.of(context).size.width),
                      color: Colors.white,
                    ),
                  ],
                ),
                Image.network(
                  pokemonService.getPokemonImageURL(args.pokemonId),
                  fit: BoxFit.cover,
                  width: (MediaQuery.of(context).size.width),
                  height: (MediaQuery.of(context).size.width),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        args.pokemonName,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
