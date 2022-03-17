import 'package:flutter/material.dart';
import 'package:pokedex/extensions/string_extensions.dart';
import 'package:pokedex/services/pokemon_services.dart';
import 'package:pokedex/models/pokemon_list_response.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Pokedex'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController scrollController = ScrollController();
  PokemonService pokemonService = PokemonService();
  List<PokemonListResponseResult> pokemons = [];
  int maxData = 0;
  bool availableLoadMore = false;
  bool isLoadMore = false;
  int page = 1;
  int limit = 20;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(scrollHandler);
    initData(false, 0, limit);
  }

  // First load handler

  void initData(bool isLoadMore, int offset, int limit) {
    pokemonService.getPokemonList(offset: offset, limit: limit).then((value) {
      maxData = value.count;
      if (isLoadMore) {
        pokemons.addAll(value.results);
      } else {
        pokemons = value.results;
      }
      availableLoadMore = (page * limit) < maxData;
      if (availableLoadMore) {
        page += 1;
      }
      isLoadMore = false;
      setState(() {});
    });
  }

  // Pull to refresh handler

  Future<void> refreshData() async {
    isLoadMore = false;
    page = 1;
    setState(() {});
    initData(false, 0, limit);
  }

  // Load more handler

  void scrollHandler() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        availableLoadMore &&
        !isLoadMore) {
      isLoadMore = true;
      setState(() {});
      var offset = (page - 1) * limit;
      initData(isLoadMore, offset, limit);
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: ListView.separated(
          controller: scrollController,
          itemBuilder: (context, index) {
            PokemonListResponseResult pokemon = pokemons[index];
            String imageURL =
                pokemonService.getPokemonImageURL(pokemon.url.getPokemonId());
            return ListTile(
              leading: Image.network(
                imageURL,
                fit: BoxFit.cover,
              ),
              title: Text(pokemon.name.capitalize()),
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: pokemons.length,
        ),
      ),
    );
  }
}
