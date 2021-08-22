import 'package:flutter/material.dart';

class Configuracion extends StatelessWidget {
  final opciones = ["uno", "dos", "tres", "cuatro", "cinco"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configuracion"),
      ),
      body: _lista(context),
    );
  }

  Widget _lista(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.location_city),
          trailing: Icon(Icons.keyboard_arrow_right),
          title: Text('Lugares'),
          onTap: () => Navigator.pushNamed(context, 'lugares'),
          subtitle: Text("Aqui puedes modificar los lugares"),
        ),
        // ListTile(
        //   title: Text('Talla'),
        //   leading: Icon(Icons.accessibility),
        //   trailing: Icon(Icons.keyboard_arrow_right),
        //   subtitle: Text("Aqui puedes modificar las tallas"),
        // ),
        // ListTile(
        //   title: Text('Genero'),
        //   leading: Icon(Icons.supervised_user_circle),
        //   trailing: Icon(Icons.keyboard_arrow_right),
        //   subtitle: Text("Aqui puedes modificar los generos"),
        // ),
      ],
    );
  }
}
