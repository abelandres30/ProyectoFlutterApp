import 'package:flutter/material.dart';
import 'package:proyecto_gibran/src/pages/Carrito.dart';
import 'package:proyecto_gibran/src/pages/Nodisponible.dart';
import 'package:proyecto_gibran/src/pages/configuracion.dart';
import 'package:proyecto_gibran/src/pages/MenuPrincipal.dart';
import 'package:proyecto_gibran/src/pages/MenuPrincipalHombre.dart';
import 'package:proyecto_gibran/src/pages/MenuPrincipalMujer.dart';
import 'package:proyecto_gibran/src/pages/MenuPrincipalNi%C3%B1a.dart';
import 'package:proyecto_gibran/src/pages/MenuPrincipalNi%C3%B1o.dart';
import 'Pedidos.dart';

class Home extends StatefulWidget {
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int _selectDrawlerItem = 0;
  _getDrawlerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return PaginaMenu();
      case 1:
        return Clientes();
      case 2:
        return Configuracion();
      case 3:
        return PaginaMenuHombre();
      case 4:
        return PaginaMenuMujer();
      case 5:
        return PaginaMenuNino();
      case 6:
        return PaginaMenuNina();
      case 7:
        return Carrito();
      case 8:
        return PaginaNodisponible();
    }
  }

  _onSelecItem(int pos) {
    Navigator.of(context).pop();
    setState(() {
      _selectDrawlerItem = pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Negocio de ropa'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Maria'),
              accountEmail: Text('Ma_jesusalmada@hotmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(
                  'M',
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              title: Text('Menu'),
              leading: Icon(Icons.menu),
              onTap: () {
                _onSelecItem(0);
              },
            ),
            ListTile(
              title: Text('Hombre'),
              leading: Icon(Icons.person),
              onTap: () {
                _onSelecItem(3);
              },
            ),
            ListTile(
              title: Text('Mujer'),
              leading: Icon(Icons.person),
              onTap: () {
                _onSelecItem(4);
              },
            ),
            ListTile(
              title: Text('Niño'),
              leading: Icon(Icons.person_pin),
              onTap: () {
                _onSelecItem(5);
              },
            ),
            ListTile(
              title: Text('Niña'),
              leading: Icon(Icons.person_pin),
              onTap: () {
                _onSelecItem(6);
              },
            ),
            ListTile(
              title: Text('No disponibles'),
              leading: Icon(Icons.delete),
              onTap: () {
                _onSelecItem(8);
              },
            ),
            ListTile(
              title: Text('Pedidos'),
              leading: Icon(Icons.list),
              onTap: () {
                _onSelecItem(1);
              },
            ),
            ListTile(
              title: Text('Carrito'),
              leading: Icon(Icons.shopping_cart),
              onTap: () {
                _onSelecItem(7);
              },
            ),
            ListTile(
              title: Text('Configuracion'),
              leading: Icon(Icons.settings),
              onTap: () {
                _onSelecItem(2);
              },
            ),
          ],
        ),
      ),
      body: _getDrawlerItemWidget(_selectDrawlerItem),
    );
  }
}
