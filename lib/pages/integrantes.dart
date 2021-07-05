import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Integrantes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Integrantes del equipo'),
          centerTitle: true,
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              buildCard("Carlos Daniel Cruz Caballero", "183403"),
              buildCard("Elías Roblero Pérez", "183414"),
              buildCard("Eduardo Marcelino Diaz Diaz", "183442"),
              buildCard("Hugo Eduardo Ruíz Pérez", "183382"),
            ]));
  }

  Row buildCard(String nombre, String matricula) {
    return Row(children: [
      SizedBox(
        width: 20,
      ),
      Image.asset(
        'assets/images/icon_dev.png',
        width: 80.0,
        height: 80.0,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Text(
              nombre,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
            child: Text(
              "Matrícula: $matricula",
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    ]);
  }
}
