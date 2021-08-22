import 'package:flutter/material.dart';
import 'package:proyecto_gibran/src/models/lugares.dart';
import 'package:proyecto_gibran/src/providers/luagres.dart';

class LugarPage extends StatefulWidget {
  @override
  _LugarPageState createState() => _LugarPageState();
}

class _LugarPageState extends State<LugarPage> {
  final lugaresProvider = new LugaresProvider();
  final formkey = GlobalKey<FormState>();
  final scaffolkey = GlobalKey<ScaffoldState>();

  // aqui es para comunicarse con el modal con el cual nos comunicamos con la base de datos
  LugaresModel lugar = new LugaresModel();
  LugaresModel id = new LugaresModel();

  bool _guardando = false;
  @override
  Widget build(BuildContext context) {
    final LugaresModel prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null) {
      lugar = prodData;
    }
    return Scaffold(
      key: scaffolkey,
      appBar: AppBar(
        title: Text("lugar"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formkey,
            child: Column(
              children: <Widget>[
                _crearNombre(),
                _crearBoton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: lugar.nombre,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'lugar'),
      onSaved: (value) => lugar.nombre = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre del lugar';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed: (_guardando) ? null : _submit,
    );
  }

  void _submit() async {
    if (!formkey.currentState.validate()) return;
    formkey.currentState.save();
    setState(() {
      _guardando = true;
    });
    if (lugar.id == null) {
      lugaresProvider.crearLugar(lugar);
      setState(() {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: new Text("Su subio correctamente"),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text("cerrar"),
                  onPressed: _cerrar,
                ),
              ],
            );
          },
        );
      });
    } else {
      lugaresProvider.editarProducto(lugar);
      setState(() {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: new Text("Su edito correctamente"),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text("cerrar"),
                  onPressed: _cerrar,
                ),
              ],
            );
          },
        );
      });
    }
    setState(() {
      _guardando = false;
    });
    mostrarSnackbar('Registro guardado');
  }

  void mostrarSnackbar(String mensaje) {
    final snackBar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );
    scaffolkey.currentState.showSnackBar(snackBar);
  }

  void _cerrar() async {
    Navigator.of(context, rootNavigator: true).pop('dialog');
    Navigator.of(context).pop();
  }
}
