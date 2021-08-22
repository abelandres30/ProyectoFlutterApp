import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:proyecto_gibran/src/models/producto_model.dart';
import 'package:proyecto_gibran/src/providers/productos_servicio.dart';

enum ConfirmAction { CANCEL, ACCEPT }

class PaginaMenuMujer extends StatefulWidget {
  @override
  _PaginaMenuMujerState createState() => _PaginaMenuMujerState();
}

class _PaginaMenuMujerState extends State<PaginaMenuMujer> {
  final productosProvider = new ProductosProvider();

  final formkey = GlobalKey<FormState>();
  TextEditingController editingController = TextEditingController();
  var cambiar = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Menu de ropa de mujer')),
        body: _crearListado(1 + cambiar),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 22.0),
          // this is ignored if animatedIcon is non null
          // child: Icon(Icons.add),
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          onOpen: () => print('OPENING DIAL'),
          onClose: () => print('DIAL CLOSED'),
          tooltip: 'Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          backgroundColor: Colors.blueGrey,
          foregroundColor: Colors.black,
          elevation: 8.0,
          shape: CircleBorder(),
          children: [
            SpeedDialChild(
                child: Icon(Icons.filter),
                backgroundColor: Colors.blue,
                label: 'Todo',
                onTap: () {
                  setState(() {
                    cambiar = 0;
                  });
                }),
            SpeedDialChild(
                child: Icon(Icons.filter),
                backgroundColor: Colors.blue,
                label: 'talla grande',
                onTap: () {
                  setState(() {
                    cambiar = 1;
                  });
                }),
            SpeedDialChild(
                child: Icon(Icons.filter),
                backgroundColor: Colors.blue,
                label: 'talla mediana',
                onTap: () {
                  setState(() {
                    cambiar = 2;
                  });
                }),
            SpeedDialChild(
                child: Icon(Icons.filter),
                backgroundColor: Colors.blue,
                label: 'talla chica',
                onTap: () {
                  setState(() {
                    cambiar = 3;
                  });
                }),
            SpeedDialChild(
                child: Icon(Icons.filter),
                backgroundColor: Colors.blue,
                label: 'talla extra grande',
                onTap: () {
                  setState(() {
                    cambiar = 4;
                  });
                }),
          ],
        ));
  }

  Widget _crearListado(numero) {
    return FutureBuilder(
      future: productosProvider.cargarProductoMujer(numero),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          final productos = snapshot.data;
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: productos.length,
            itemBuilder: (context, i) => _crearItem(context, productos[i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, ProductoModel producto) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(color: Colors.red),
        onDismissed: (direccion) {
          return showDialog(
            context: context,
            barrierDismissible: false, // user must tap button for close dialog!
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Eliminar producto?'),
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
                      productosProvider.borrarProducto(
                          producto.id, producto.fotoUrl);
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
              (producto.fotoUrl == null)
                  ? Image(image: AssetImage('assets/no-image.png'))
                  : FadeInImage(
                      image: NetworkImage(producto.fotoUrl),
                      placeholder: AssetImage('assets/jar-loading.gif'),
                      height: 250.0,
                      width: double.infinity,
                      fit: BoxFit.cover),
              ListTile(
                title: Text(
                  '${producto.titulo} - ${producto.valor}',
                  style: TextStyle(fontSize: 20.0),
                ),
                subtitle: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Talla = ${producto.talla}',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '/ Sexo = ${producto.sexo}',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    )
                  ],
                ),
                onTap: () => Navigator.pushNamed(context, 'producto',
                    arguments: producto),
              ),
            ],
          ),
        ));
  }
}
