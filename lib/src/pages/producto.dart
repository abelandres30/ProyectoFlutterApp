import 'dart:io';

import 'package:flutter/material.dart';
import 'package:proyecto_gibran/src/models/producto_model.dart';
import 'package:proyecto_gibran/src/providers/productos_servicio.dart';

class ProductoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  //  esta es la lista para las opciones de talla

  //  esta es la lista para las opciones de sexo
  final productosProvider = new ProductosProvider();
  final formkey = GlobalKey<FormState>();
  final scaffolkey = GlobalKey<ScaffoldState>();

  // aqui es para comunicarse con el modal con el cual nos comunicamos con la base de datos
  ProductoModel producto = new ProductoModel();
  bool _guardando = false;
  File foto;
  String _value = "";
  String _value2 = "";
  String _value3 = "";
  String _value4 = "";
  String _titulo;
  int _valor;
  int _total;

  @override
  Widget build(BuildContext context) {
    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null) {
      producto = prodData;
    }
    if (_value != "") {
    } else {
      _value = "tallas";
    }
    if (_value2 != "") {
    } else {
      _value2 = "genero";
    }
    if (_value3 != "") {
    } else {
      _value3 = "tipo";
    }
    if (_value4 != "") {
    } else {
      _value4 = "Estatus";
    }

    return Scaffold(
      key: scaffolkey,
      appBar: AppBar(
        title: Text("producto"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: (EdgeInsets.all(1.0)),
          child: Form(
            key: formkey,
            child: Column(
              children: <Widget>[
                _mostrarFoto(),
                Text(
                  'Datos del producto',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                _crearNombre(1),
                Text(
                  producto.disponible,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                _mostrarDatos(),
                Text(
                  'Editar datos',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                _crearNombre(2),
                _crearPrecio(),
                _crearTotal(),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _crearTalla(),
                    ),
                    Expanded(
                      child: _crearSexo(),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _crearTipo(),
                    ),
                    Expanded(child: _disponible()),
                  ],
                ),
                _crearBoton(1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre(pos) {
    if (pos == 1) {
      return Column(children: <Widget>[
        Center(
            child: Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text(producto.titulo,
                    style: TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold)))),
      ]);
    } else {
      return TextFormField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(labelText: 'titulo'),
          onChanged: (value) {
            setState(() {
              _titulo = value;
            });
          });
    }
  }

  Widget _crearPrecio() {
    return TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: 'precio'),
        onChanged: (value) {
          setState(() {
            _valor = int.parse(value);
          });
        });
  }

  Widget _crearTalla() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: DropdownButton(
          value: _value,
          items: [
            DropdownMenuItem(
              child: Text("Lista de tallas"),
              value: "tallas",
            ),
            DropdownMenuItem(
              child: Text("Extra grande"),
              value: "extra grande",
            ),
            DropdownMenuItem(
              child: Text("Grande"),
              value: "grande",
            ),
            DropdownMenuItem(child: Text("Mediana"), value: "mediana"),
            DropdownMenuItem(child: Text("Chica"), value: "chica"),
            DropdownMenuItem(child: Text("Extra chica"), value: "extra chica")
          ],
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          }),
    );
  }

  Widget _disponible() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: DropdownButton(
          value: _value4,
          items: [
            DropdownMenuItem(
              child: Text("Estatus"),
              value: "Estatus",
            ),
            DropdownMenuItem(
              child: Text("disponible"),
              value: "disponible",
            ),
            DropdownMenuItem(
              child: Text("No disponible"),
              value: "no disponible",
            ),
          ],
          onChanged: (value) {
            setState(() {
              _value4 = value;
            });
          }),
    );
  }

  Widget _crearTotal() {
    return TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: 'total de elementos'),
        // onSaved: (value) => _total = int.parse(value),
        onChanged: (value) {
          setState(() {
            _total = int.parse(value);
          });
        });
  }

  Widget _crearTipo() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: DropdownButton(
          value: _value3,
          items: [
            DropdownMenuItem(
              child: Text("Lista de tipos"),
              value: "tipo",
            ),
            DropdownMenuItem(
              child: Text("Playera suave"),
              value: "playeras suaves",
            ),
            DropdownMenuItem(
              child: Text("polo"),
              value: "playeras polo",
            ),
            DropdownMenuItem(child: Text("short"), value: "short"),
            DropdownMenuItem(child: Text("jeans"), value: "jeans"),
            DropdownMenuItem(child: Text("sudadera"), value: "sudadera")
          ],
          onChanged: (value) {
            setState(() {
              _value3 = value;
            });
          }),
    );
  }

  Widget _crearBoton(pos) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed: (_guardando) ? null : _submit,
    );
  }

  Widget _crearSexo() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: DropdownButton(
          value: _value2,
          items: [
            DropdownMenuItem(
              child: Text("Lista de genero"),
              value: "genero",
            ),
            DropdownMenuItem(
              child: Text("Hombre"),
              value: "hombre",
            ),
            DropdownMenuItem(
              child: Text("Mujer"),
              value: "mujer",
            ),
            DropdownMenuItem(child: Text("Niño"), value: "niño"),
            DropdownMenuItem(child: Text("Niña"), value: "niña"),
          ],
          onChanged: (value) {
            setState(() {
              _value2 = value;
            });
          }),
    );
  }

  void _submit() async {
    if (!formkey.currentState.validate()) return;
    formkey.currentState.save();
    setState(() {
      _guardando = true;
    });

    if (producto.id == null) {
      productosProvider.crearProducto(producto);
    } else {
      if (_value == "tallas") {
      } else {
        producto.talla = _value;
      }
      if (_value2 == "genero") {
      } else {
        producto.sexo = _value2;
      }
      if (_value3 == "tipo") {
      } else {
        producto.tipo = _value3;
      }
      if (_value4 == "Estatus") {
      } else {
        producto.disponible = _value4;
      }
      if (_titulo == "" || _titulo == null) {
      } else {
        producto.titulo = _titulo;
      }
      if (_valor == 0 || _valor == null) {
      } else {
        producto.valor = _valor;
      }
      if (_total == 0 || _total == null) {
      } else {
        producto.total = _total;
      }

      productosProvider.editarProducto(producto);
    }
    setState(() {
      _guardando = false;
    });
    mostrarSnackbar('Registro guardado');
    Navigator.pop(context);
  }

  Widget _mostrarFoto() {
    if (producto.fotoUrl != null) {
      return FadeInImage(
          image: NetworkImage(producto.fotoUrl),
          placeholder: AssetImage('assets/jar-loading.gif'),
          height: 300.0,
          fit: BoxFit.contain);
    } else {
      return Image(
        image: AssetImage(foto?.path ?? 'assets/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    }
  }

  void mostrarSnackbar(String mensaje) {
    final snackBar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );
    scaffolkey.currentState.showSnackBar(snackBar);
  }

  _mostrarDatos() {
    if (producto.id != null) {
      return Row(
        children: <Widget>[
          Expanded(
            child: ListTile(
              title: Text(
                'VALOR',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(producto.valor.toString()),
            ),
          ),
          Expanded(
            child: ListTile(
              title: Text(
                'TIPO',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(producto.tipo.toString()),
            ),
          ),
          Expanded(
            child: ListTile(
              title: Text(
                'TALLA',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(producto.talla.toString()),
            ),
          ),
          Expanded(
            child: ListTile(
              title: Text(
                'GENERO',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(producto.sexo.toString()),
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: <Widget>[],
      );
    }
  }
}
