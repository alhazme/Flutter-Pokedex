import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pokedex/extensions/string_extensions.dart';
import 'package:pokedex/extensions/colors_extensions.dart';
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
  List<String> pokemonTypes = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 1), () {
      final args =
          ModalRoute.of(context)!.settings.arguments as DetailPageArguments;
      initPokemonDetail(args.pokemonId);
    });
  }

  Future<void> initPokemonDetail(String pokemonId) async {
    var data = await pokemonService.getPokemonDetail(pokemonId: pokemonId);
    data.types.forEach((type) {
      pokemonTypes.add(type.type.name);
      setState(() {});
    });
  }

  Widget pokemonImage(String pokemonId) {
    Color color = Color(0xDD000000);
    List<Color> colors = [];
    for (var pokemonType in pokemonTypes) {
      colors.add(color.getColor(pokemonType));
    }
    return Stack(
      children: <Widget>[
        Container(
            width: (MediaQuery.of(context).size.width),
            height: (MediaQuery.of(context).size.width),
            color: colors.length != 1 ? null : colors.first,
            decoration: colors.length > 1
                ? BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        colors.first,
                        colors.last,
                      ],
                    ),
                  )
                : null),
        Image.network(
          pokemonService.getPokemonImageURL(pokemonId),
          fit: BoxFit.cover,
          width: (MediaQuery.of(context).size.width),
          height: (MediaQuery.of(context).size.width),
        ),
      ],
    );
  }

  List<Widget> pokemonTypeWidgets(List<String> pokemonTypes) {
    Color color = Color(0xDD000000);
    return pokemonTypes
        .map((name) => new Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.fromLTRB(8, 16, 8, 16),
              decoration: BoxDecoration(
                  color: color.getColor(name),
                  border: Border.all(
                    color: color.getColor(name),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Text(
                name.capitalize(),
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ))
        .toList();
  }

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
        color: Colors.white,
        child: Row(
          children: [
            Column(
              children: [
                pokemonImage(args.pokemonId),
                Row(
                  children: pokemonTypeWidgets(pokemonTypes),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
