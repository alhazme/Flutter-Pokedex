import 'package:flutter/painting.dart';

extension ColorsExtension on Color {
  Color getColor(String type) {
    switch (type) {
      case "bug":
        {
          return Color(0xDDA8B820);
        }
        break;
      case "dark":
        {
          return Color(0xDD705848);
        }
        break;
      case "dragon":
        {
          return Color(0xDD7038F8);
        }
        break;
      case "electric":
        {
          return Color(0xDDF8D030);
        }
        break;
      case "fairy":
        {
          return Color(0xDDEE99AC);
        }
        break;
      case "fighting":
        {
          return Color(0xDDC03028);
        }
        break;
      case "fire":
        {
          return Color(0xDDF08030);
        }
        break;
      case "flying":
        {
          return Color(0xDDA890F0);
        }
        break;
      case "ghost":
        {
          return Color(0xDD705898);
        }
        break;
      case "grass":
        {
          return Color(0xDD78C850);
        }
        break;
      case "ground":
        {
          return Color(0xDDE0C068);
        }
        break;
      case "ice":
        {
          return Color(0xDD98D8D8);
        }
        break;
      case "poison":
        {
          return Color(0xDDA040A0);
        }
        break;
      case "psychic":
        {
          return Color(0xDDF85888);
        }
        break;
      case "rock":
        {
          return Color(0xDDB8A038);
        }
        break;
      case "steel":
        {
          return Color(0xDDB8B8D0);
        }
        break;
      case "water":
        {
          return Color(0xDD6890F0);
        }
        break;
      default:
        {
          return Color(0xDDA8A878);
        }
        break;
    }
  }
}
