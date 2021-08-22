import 'package:flutter/material.dart';
import 'package:proyecto_gibran/src/models/carrito.dart';
import 'package:proyecto_gibran/src/providers/carrito.dart';

class Carrito extends StatefulWidget {
  @override
  _CarritoState createState() => _CarritoState();
}

class _CarritoState extends State<Carrito> {
  final carrito = new CarritoProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _crearListado(),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: carrito.cargarCarrito(),
      builder:
          (BuildContext context, AsyncSnapshot<List<CarritoModel>> snapshot) {
        if (snapshot.hasData) {
          final carrito = snapshot.data;
          return ListView.builder(
            itemCount: carrito.length,
            itemBuilder: (context, i) => _crearItem(context, carrito[i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, CarritoModel carrito) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(color: Colors.red),
        onDismissed: (direccion) {},
        child: Card(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.assignment),
                trailing: Icon(Icons.keyboard_arrow_right),
                title: Text(
                  '${carrito.usuario}',
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                subtitle: Row(
                  children: [
                    Expanded(
                      child: Text('${carrito.UsuarioCorreo}',
                          style: TextStyle(fontSize: 15.0)),
                    ),
                  ],
                ),
                onTap: () => Navigator.pushNamed(context, 'carritoDetalle',
                    arguments: carrito),
              ),
            ],
          ),
        ));
  }
}
