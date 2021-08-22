import 'package:flutter/material.dart';
import 'package:proyecto_gibran/src/models/lugares.dart';
import 'package:proyecto_gibran/src/providers/luagres.dart';

enum ConfirmAction { CANCEL, ACCEPT }
final formkey = GlobalKey<FormState>();
final scaffolkey = GlobalKey<ScaffoldState>();

class Lugares extends StatefulWidget {
  @override
  _LugaresState createState() => _LugaresState();
}

class _LugaresState extends State<Lugares> {
  final lugaresProvider = new LugaresProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffolkey,
      appBar: AppBar(
        title: Text("Lugares Agregados"),
      ),
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: lugaresProvider.cargarLugar(),
      builder:
          (BuildContext context, AsyncSnapshot<List<LugaresModel>> snapshot) {
        if (snapshot.hasData) {
          final lugares = snapshot.data;
          return ListView.builder(
            itemCount: lugares.length,
            itemBuilder: (context, i) => _crearItem(context, lugares[i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, LugaresModel lugar) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(color: Colors.red),
        onDismissed: (direccion) {
          return showDialog(
            context: context,
            barrierDismissible: false, // user must tap button for close dialog!
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Eliminar lugar?'),
                actions: <Widget>[
                  FlatButton(
                    child: const Text('cancelar'),
                    onPressed: () {
                      setState(() {
                        Navigator.of(context).pop(ConfirmAction.CANCEL);
                      });
                    },
                  ),
                  FlatButton(
                    child: const Text('Eliminar'),
                    onPressed: () {
                      lugaresProvider.eliminarlugar(lugar.id);
                      Navigator.of(context).pop(ConfirmAction.ACCEPT);
                    },
                  )
                ],
              );
            },
          );
        },
        child: Card(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  ' ${lugar.nombre}',
                  style: TextStyle(fontSize: 28.0),
                ),
                onTap: () =>
                    Navigator.pushNamed(context, 'lugar', arguments: lugar),
              ),
            ],
          ),
        ));
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, 'lugar'),
    );
  }

  // _cerrar(BuildContext context) async {
  //   Navigator.of(context, rootNavigator: true).pop('dialog');
  //   Navigator.of(context).pop();
  // }
}
