import 'dart:convert';
import 'package:aula1310/models/restaurante.dart';
import 'package:http/http.dart' as http;

class RestauranteApi {
  static Future<List<Restaurante>> getRestaurante() async {
    var uri = Uri.https(
        'travel-advisor.p.rapidapi.com', '/restaurants/list-by-latlng', {
      "latitude": "-27.8167",
      "longitude": "-50.3264",
      "limit": "30",
      "currency": "USD",
      "distance": "2",
      "open_now": "false",
      "lunit": "km",
      "lang": "en_US"
    });

    final response = await http.get(uri, headers: {
      "x-rapidapi-host": "travel-advisor.p.rapidapi.com",
      "x-rapidapi-key": "a976fc0ed3msh36502db821c63cbp12dacejsn8b6cf1356459",
      "useQueryString": "true"
    });

    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['data']) {
      _temp.add(i);
    }

    return Restaurante.restaurantesFromSnapshot(_temp);
  }
}
