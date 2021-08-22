import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:proyecto_gibran/src/models/pedido_model.dart';
import 'package:proyecto_gibran/src/models/producto_model.dart';
import 'package:proyecto_gibran/src/models/cuenta.dart';

// import 'package:proyecto_gibran/src/models/producto_pedido.dart';
import 'package:proyecto_gibran/src/providers/pedido.servicio.dart';
import 'package:proyecto_gibran/src/providers/producto_pedido.service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_gibran/src/providers/productos_servicio.dart';

enum ConfirmAction { CANCEL, ACCEPT }

class PedidoPage extends StatefulWidget {
  @override
  _PedidoPageState createState() => _PedidoPageState();
}

class _PedidoPageState extends State<PedidoPage> {
  final String _url = 'https://proyectogibranflutter.firebaseio.com';

  final productosProvider = new ProductosProvider();
  final pedidosProvider = new PedidosProvider();
  final productoPedidoProvider = new ProductoPedidoProvider();
  final formkey = GlobalKey<FormState>();
  final scaffolkey = GlobalKey<ScaffoldState>();
  ProductoModel producto2 = new ProductoModel();

  PedidoModel pedido = new PedidoModel();
  @override
  Widget build(BuildContext context) {
    final PedidoModel prodData = ModalRoute.of(context).settings.arguments;

    if (prodData != null) {
      pedido = prodData;
    }
    return Scaffold(
      key: scaffolkey,
      appBar: AppBar(
        title: Text("Pedido"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.fromLTRB(15.0, 5.0, 0.0, 0.0),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Datos del pedido',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: [
                          _mostrarNombre(),
                          _mostrarTelefono(),
                          _mostrarLugar(),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          _mostrarTotal(),
                          _mostrarDia(),
                          _mostrarHora(),
                        ],
                      ),
                    ),
                  ],
                ),
                _pedidosLista(),
                _mostrarCantidad(),
                _crearListado(),
                Row(
                  children: [
                    Expanded(
                      child: _crearBoton(),
                    ),
                    Expanded(
                      child: _botonEliminar(),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _mostrarNombre() {
    return TextFormField(
      initialValue: pedido.nombre,
      enabled: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Nombre del cliente'),
      style: TextStyle(fontSize: 25.0),
    );
  }

  Widget _mostrarLugar() {
    return TextFormField(
      initialValue: pedido.lugarencuentro,
      enabled: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Lugar de encuentro'),
      style: TextStyle(fontSize: 25.0),
    );
  }

  Widget _mostrarCantidad() {
    return Text.rich(
      TextSpan(
          text: '# elementos ${pedido.cantidadelementos}',
          style: TextStyle(fontSize: 20.0) // default text style
          ),
    );
  }

  Widget _mostrarTotal() {
    return TextFormField(
      initialValue: pedido.total.toString(),
      enabled: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Total de la compra'),
      style: TextStyle(fontSize: 25.0),
    );
  }

  Widget _mostrarDia() {
    return TextFormField(
      initialValue: pedido.dia.toString(),
      enabled: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Dia del encuentro'),
      style: TextStyle(fontSize: 25.0),
    );
  }

  Widget _mostrarHora() {
    return TextFormField(
      initialValue: pedido.hora.toString(),
      enabled: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Hora del encuentro'),
      style: TextStyle(fontSize: 25.0),
    );
  }

  Widget _botonEliminar() {
    return RaisedButton(
      onPressed: _asyncConfirmDialog,
      textColor: Colors.white,
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFFB71C1C),
              Color(0xFFB71C1C),
              Color(0xFFB71C1C),
            ],
          ),
        ),
        padding: const EdgeInsets.all(10.0),
        child: const Text('Cancelar Pedido', style: TextStyle(fontSize: 20)),
      ),
    );
  }

  // aqui empieza el espacio donde salen los productos de la lista del pedido
  Widget _pedidosLista() {
    return Text.rich(
      TextSpan(
          text: 'Productos del pedido',
          style: TextStyle(fontSize: 25.0) // default text style
          ),
    );
  }

  Widget _crearListado() {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: <Widget>[
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: pedido.producto.length,
            itemBuilder: (BuildContext context, i) {
              return Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      (pedido.producto[i]["imagen"].toString() == null)
                          ? Image(image: AssetImage('assets/no-image.png'))
                          : FadeInImage(
                              image: NetworkImage(
                                  pedido.producto[i]["imagen"].toString()),
                              placeholder: AssetImage('assets/jar-loading.gif'),
                              height: 150.0,
                              width: 200.0,
                              fit: BoxFit.cover),
                      ListTile(
                          title: Text(
                            '${pedido.producto[i]['nombre'].toString()}',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Container(
                            child: Column(
                              children: [
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        'Precio - ${pedido.producto[i]['precio'].toString()}MXN',
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Tipo - ${pedido.producto[i]['tipo'].toString()}',
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        'Talla - ${pedido.producto[i]['talla'].toString()}',
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Genero - ${pedido.producto[i]['sexo'].toString()}',
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _crearBoton() {
    return RaisedButton(
      onPressed: _submit,
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFF0D47A1),
              Color(0xFF1976D2),
              Color(0xFF42A5F5),
            ],
          ),
        ),
        padding: const EdgeInsets.all(10.0),
        child: const Text('Enviar Mensaje', style: TextStyle(fontSize: 20)),
      ),
    );
  }

  Widget _mostrarTelefono() {
    return TextFormField(
      initialValue: pedido.telefono.toString(),
      enabled: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Nombre del cliente'),
      style: TextStyle(fontSize: 25.0),
    );
  }

  void _submit() async {
    var phone = "52-" + this.pedido.telefono.toString();
    var whatsappUrl = "whatsapp://send?phone=$phone";
    await canLaunch(whatsappUrl)
        ? launch(whatsappUrl)
        : print(
            "open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
  }

  void _asyncConfirmDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cancelar Pedido?'),
          content: const Text(
              'al Cancelar el pedido se cancelaran tambien los productos.'),
          actions: <Widget>[
            FlatButton(
              child: const Text('salir'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            FlatButton(
              child: const Text('Cancelar pedido'),
              onPressed: () {
                _eliminarproductopedido();
                Navigator.of(context).pop(ConfirmAction.ACCEPT);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialog(
                      title: new Text("Se cancelo correctamente"),
                      actions: <Widget>[
                        // usually buttons at the bottom of the dialog
                        new FlatButton(
                          child: new Text("Close"),
                          onPressed: _cerrar,
                        ),
                      ],
                    );
                  },
                );
              },
            )
          ],
        );
      },
    );
  }

  void _eliminarproductopedido() async {
    final url = '$_url/productos.json';
    final url2 = '$_url/cuentas.json';
    final resp = await http.get(url, headers: {"Accept": "application/json"});
    final resp2 = await http.get(url2, headers: {"Accept": "application/json"});

    final Map<String, dynamic> decodeData = jsonDecode(resp.body);
    final Map<String, dynamic> decodeData2 = jsonDecode(resp2.body);

    // final List<ProductoPedidoModel> productos = new List();
    pedido.producto.forEach((element) {
      ProductoModel producto = new ProductoModel();
      decodeData.forEach((id, productos) {
        if (id == element["llaveproducto"]) {
          producto.disponible = "disponible";
          producto.fotoUrl = productos["fotoUrl"];
          producto.id = id;
          producto.sexo = productos["sexo"];
          producto.talla = productos["talla"];
          producto.tipo = productos["tipo"];
          producto.titulo = productos["titulo"];
          producto.total = productos["total"];
          producto.valor = productos["valor"];
          productosProvider.editarProducto(producto);
        }
      });
    });
    pedidosProvider.eliminarpedido(pedido.id);
    CuentaModel cuentaUser = new CuentaModel();
    decodeData2.forEach((id, cuenta) {
      if (pedido.correo == cuenta['correo']) {
        cuentaUser.numeropedidos = cuenta['numeropedidos'] - 1;
        cuentaUser.nombre = cuenta['nombre'];
        cuentaUser.numero = cuenta['numero'];
        cuentaUser.correo = cuenta['correo'];
        this.productosProvider.editarcuenta(cuentaUser, id);
      }
    });
  }

  void _cerrar() async {
    Navigator.of(context, rootNavigator: true).pop('dialog');
    Navigator.of(context).pop();
  }
}
