import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:proyecto_gibran/src/models/carrito.dart';
import 'package:proyecto_gibran/src/providers/carrito.dart';
import 'package:proyecto_gibran/src/providers/carrito.dart';
import 'package:http/http.dart' as http;

enum ConfirmAction { CANCEL, ACCEPT }

class CarritoDetallePage extends StatefulWidget {
  @override
  _CarritoDetallePageState createState() => _CarritoDetallePageState();
}

class _CarritoDetallePageState extends State<CarritoDetallePage> {
  final String _url = 'https://proyectogibranflutter.firebaseio.com';

  final carritoInfo = new CarritoProvider();
  final formkey = GlobalKey<FormState>();
  final scaffolkey = GlobalKey<ScaffoldState>();
  int contadorTotal = 0;
  int contadorValor = 0;
  CarritoModel carrito = new CarritoModel();

  @override
  Widget build(BuildContext context) {
    final CarritoModel prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null) {
      carrito = prodData;
    }

    return Scaffold(
      key: scaffolkey,
      appBar: AppBar(
        title: Text("${carrito.usuario}"),
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
                  'DATOS DEL CARRITO',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
                ),
                _crearListado(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: cargarCarrito(),
      builder:
          (BuildContext context, AsyncSnapshot<List<CarritoModel>> snapshot) {
        if (snapshot.hasData) {
          final carritoNew = snapshot.data;
          return SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: (Text(
                          "# de elementos",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        )),
                        subtitle: Text(
                          this.contadorTotal.toString(),
                          style: TextStyle(fontSize: 20.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: (Text(
                          "Total del carrito",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        )),
                        subtitle: Text(
                          "${this.contadorValor.toString()} MXN",
                          style: TextStyle(fontSize: 20.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Produtos',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: carritoNew.length,
                  itemBuilder: (BuildContext context, i) {
                    return Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            (carritoNew[i].Imagen.toString() == null)
                                ? Image(
                                    image: AssetImage('assets/no-image.png'))
                                : FadeInImage(
                                    image: NetworkImage(
                                        carritoNew[i].Imagen.toString()),
                                    placeholder:
                                        AssetImage('assets/jar-loading.gif'),
                                    height: 150.0,
                                    width: 200.0,
                                    fit: BoxFit.cover),
                            ListTile(
                                title: Text(
                                  '${carritoNew[i].titulo.toString()}',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              'Precio - ${carritoNew[i].valor.toString()}MXN',
                                              style: TextStyle(fontSize: 20.0),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Tipo - ${carritoNew[i].tipo.toString()}',
                                              style: TextStyle(fontSize: 20.0),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              'Talla - ${carritoNew[i].talla.toString()}',
                                              style: TextStyle(fontSize: 20.0),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Genero - ${carritoNew[i].genero.toString()}',
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
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<List<CarritoModel>> cargarCarrito() async {
    this.contadorTotal = 0;
    this.contadorValor = 0;
    final url = '$_url/carrito.json';
    final resp = await http.get(url);
    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<CarritoModel> carrito2 = new List();

    if (decodeData == null) return [];
    decodeData.forEach((id, carritoDate) {
      if (id != "ejemplo") {
        final prodtem = CarritoModel.fromJson(carritoDate);
        if (prodtem.titulo != null) {
          if (prodtem.UsuarioCorreo == carrito.UsuarioCorreo) {
            prodtem.id = id;
            carrito2.add(prodtem);
            this.contadorTotal = this.contadorTotal + 1;
            this.contadorValor = this.contadorValor + prodtem.valor;
          }
        }
      }
    });
    return carrito2;
  }
}
