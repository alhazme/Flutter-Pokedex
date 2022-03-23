class PokemonDetailResponse {
  int id;
  String name;
  int baseExperience;
  int height;
  bool isDefault;
  int order;
  int weight;
  List<PokemonDetailTypeResponse> types;

  PokemonDetailResponse(
      {required this.id,
      required this.name,
      required this.baseExperience,
      required this.height,
      required this.isDefault,
      required this.order,
      required this.weight,
      required this.types});

  factory PokemonDetailResponse.fromJson(Map<String, dynamic> json) =>
      PokemonDetailResponse(
        id: json["id"],
        name: json["name"],
        baseExperience: json["base_experience"],
        height: json["height"],
        isDefault: json["is_default"],
        order: json["order"],
        weight: json["weight"],
        types: List<PokemonDetailTypeResponse>.from(
            json["types"].map((x) => PokemonDetailTypeResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "base_experience": baseExperience,
        "height": height,
        "is_default": isDefault,
        "order": order,
        "weight": weight,
        "types": types
      };
}

class PokemonDetailTypeResponse {
  int slot;
  PokemonDetailType type;

  PokemonDetailTypeResponse({required this.slot, required this.type});

  factory PokemonDetailTypeResponse.fromJson(Map<String, dynamic> json) =>
      PokemonDetailTypeResponse(
          slot: json["slot"], type: PokemonDetailType.fromJson(json["type"]));

  Map<String, dynamic> toJson() => {"slot": slot, "type": type};
}

class PokemonDetailType {
  String name;
  String url;

  PokemonDetailType({required this.name, required this.url});

  factory PokemonDetailType.fromJson(Map<String, dynamic> json) =>
      PokemonDetailType(name: json["name"], url: json["url"]);

  Map<String, dynamic> toJson() => {"name": name, "url": url};
}
