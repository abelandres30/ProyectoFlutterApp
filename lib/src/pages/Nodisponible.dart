import 'package:flutter/material.dart';
import 'package:proyecto_gibran/src/models/producto_model.dart';
import 'package:proyecto_gibran/src/providers/productos_servicio.dart';
import 'package:proyecto_gibran/src/providers/push_notificaciones_provider.dart';

enum ConfirmAction { CANCEL, ACCEPT }

class PaginaNodisponible extends StatefulWidget {
  @override
  _PaginaNodisponibleState createState() => _PaginaNodisponibleState();
}

class _PaginaNodisponibleState extends State<PaginaNodisponible> {
  @override
  void initState() {
    super.initState();
    final pushProvider = new PushNotificationProvider();
    pushProvider.initNotificaciones();
    pushProvider.mensajes.listen((argumento) {
      Navigator.pushNamed(context, 'pedido');
    });
  }

  final productosProvider = new ProductosProvider();

  final formkey = GlobalKey<FormState>();
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Productos no disponibles')),
      body: _crearListado(),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: productosProvider.cargarProductoNodisponible(),
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
                  '${producto.titulo} - MXN\$${producto.valor}',
                  style: TextStyle(fontSize: 17.0),
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
