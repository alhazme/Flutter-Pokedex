extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }

  String getPokemonId() {
    return replaceAll('https://pokeapi.co/api/v2/pokemon/', '')
        .replaceAll("/", "");
  }
}
