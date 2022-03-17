class PokemonListResponse {
  int count;
  dynamic next;
  dynamic previous;
  List<PokemonListResponseResult> results;

  PokemonListResponse(
      {required this.count, this.next, this.previous, required this.results});

  factory PokemonListResponse.fromJson(Map<String, dynamic> json) =>
      PokemonListResponse(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<PokemonListResponseResult>.from(
            json["results"].map((x) => PokemonListResponseResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class PokemonListResponseResult {
  String name;
  String url;

  PokemonListResponseResult({required this.name, required this.url});

  factory PokemonListResponseResult.fromJson(Map<String, dynamic> json) =>
      PokemonListResponseResult(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
