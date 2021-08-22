import 'package:flutter/material.dart';
import 'package:proyecto_gibran/src/models/pedido_model.dart';
import 'package:proyecto_gibran/src/providers/pedido.servicio.dart';

class Clientes extends StatefulWidget {
  @override
  _ClientesState createState() => _ClientesState();
}

class _ClientesState extends State<Clientes> {
  final pedidosProvider = new PedidosProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _crearListado(),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: pedidosProvider.cargarPedido(),
      builder:
          (BuildContext context, AsyncSnapshot<List<PedidoModel>> snapshot) {
        if (snapshot.hasData) {
          final pedidos = snapshot.data;
          return ListView.builder(
            itemCount: pedidos.length,
            itemBuilder: (context, i) => _crearItem(context, pedidos[i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, PedidoModel pedido) {
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
                  '${pedido.nombre}',
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                subtitle: Row(
                  children: [
                    Expanded(
                      child: Text('Elementos = ${pedido.cantidadelementos}',
                          style: TextStyle(fontSize: 15.0)),
                    ),
                    Expanded(
                        child: Text('total = ${pedido.total}',
                            style: TextStyle(fontSize: 15.0)))
                  ],
                ),
                onTap: () =>
                    Navigator.pushNamed(context, 'pedidos', arguments: pedido),
              ),
            ],
          ),
        ));
  }
}
