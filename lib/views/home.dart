import 'package:aula1310/models/restaurante.api.dart';
import 'package:aula1310/models/restaurante.dart';
import 'package:aula1310/views/widgets/restaurante_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Restaurante> _restaurantes;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    getRestaurantes();
  }

  Future<void> getRestaurantes() async {
    _restaurantes = await RestauranteApi.getRestaurante();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restaurant_menu),
              SizedBox(width: 10),
              Text('Acha Rango')
            ],
          ),
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _restaurantes.length,
                itemBuilder: (context, index) {
                  return RestauranteCard(
                      nome: _restaurantes[index].nome,
                      status: _restaurantes[index].status,
                      nota: _restaurantes[index].nota.toString(),
                      thumbnailUrl: _restaurantes[index].images);
                },
              ));
  }
}
