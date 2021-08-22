import 'dart:async';
import 'dart:convert';
import 'package:proyecto_gibran/src/models/cuenta.dart';
import 'package:proyecto_gibran/src/models/producto_model.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';

class ProductosProvider {
  final String _url = 'https://proyectogibranflutter.firebaseio.com';

  Future<bool> crearProducto(ProductoModel producto) async {
    final url = '$_url/productos.json';

    final resp = await http.post(url, body: productoModelToJson(producto));
    final decodeData = json.decode(resp.body);
    print(decodeData);
    return true;
  }

  Future<bool> editarProducto(ProductoModel producto) async {
    final url = '$_url/productos/${producto.id}.json';

    final resp = await http.put(url, body: productoModelToJson(producto));
    final decodeData = json.decode(resp.body);
    print(decodeData);
    return true;
  }

  Future<bool> editarcuenta(CuentaModel cuenta, id) async {
    final url = '$_url/cuentas/${id}.json';

    final resp = await http.put(url, body: cuentaModelToJson(cuenta));
    final decodeData = json.decode(resp.body);
    print(decodeData);
    return true;
  }

  Future<List<ProductoModel>> cargarProducto() async {
    final url = '$_url/productos.json';
    final resp = await http.get(url);
    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<ProductoModel> productos = new List();

    if (decodeData == null) return [];
    decodeData.forEach((id, producto) {
      final prodtem = ProductoModel.fromJson(producto);
      if (prodtem.titulo != null && prodtem.disponible == "disponible") {
        prodtem.id = id;
        productos.add(prodtem);
      }
    });
    return productos;
  }

  Future<List<ProductoModel>> cargarProductoNodisponible() async {
    final url = '$_url/productos.json';
    final resp = await http.get(url);
    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<ProductoModel> productos = new List();

    if (decodeData == null) return [];
    decodeData.forEach((id, producto) {
      final prodtem = ProductoModel.fromJson(producto);
      if (prodtem.titulo != null && prodtem.disponible == "no disponible") {
        prodtem.id = id;
        productos.add(prodtem);
      }
    });
    return productos;
  }

  Future<List<ProductoModel>> cargarProductoHombre(numero) async {
    final url = '$_url/productos.json';
    final resp = await http.get(url);
    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<ProductoModel> productos = new List();

    if (decodeData == null) return [];
    productos.clear();

    decodeData.forEach((id, producto) {
      final prodtem = ProductoModel.fromJson(producto);
      if (prodtem.titulo != null &&
          prodtem.sexo == "hombre" &&
          prodtem.disponible == "disponible") {
        if (numero == 1) {
          prodtem.id = id;
          productos.add(prodtem);
        } else if (numero == 2 && prodtem.talla == "grande") {
          prodtem.id = id;
          productos.add(prodtem);
          print(prodtem.talla);
        } else if (numero == 3 && prodtem.talla == "mediana") {
          prodtem.id = id;
          productos.add(prodtem);
          print(prodtem.talla);
        } else if (numero == 4 && prodtem.talla == "chica") {
          prodtem.id = id;
          productos.add(prodtem);
          print(prodtem.talla);
        } else if (numero == 5 && prodtem.talla == "extra grande") {
          prodtem.id = id;
          productos.add(prodtem);
          print(prodtem.talla);
        }
      }
    });
    return productos;
  }

  Future<List<ProductoModel>> cargarProductoMujer(numero) async {
    final url = '$_url/productos.json';
    final resp = await http.get(url);
    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<ProductoModel> productos = new List();

    if (decodeData == null) return [];
    decodeData.forEach((id, producto) {
      final prodtem = ProductoModel.fromJson(producto);
      if (prodtem.titulo != null &&
          prodtem.sexo == "mujer" &&
          prodtem.disponible == "disponible") {
        if (numero == 1) {
          prodtem.id = id;
          productos.add(prodtem);
        } else if (numero == 2 && prodtem.talla == "grande") {
          prodtem.id = id;
          productos.add(prodtem);
          print(prodtem.talla);
        } else if (numero == 3 && prodtem.talla == "mediana") {
          prodtem.id = id;
          productos.add(prodtem);
          print(prodtem.talla);
        } else if (numero == 4 && prodtem.talla == "chica") {
          prodtem.id = id;
          productos.add(prodtem);
          print(prodtem.talla);
        } else if (numero == 5 && prodtem.talla == "extra grande") {
          prodtem.id = id;
          productos.add(prodtem);
          print(prodtem.talla);
        }
      }
    });
    return productos;
  }

  Future<List<ProductoModel>> cargarProductoNino(numero) async {
    final url = '$_url/productos.json';
    final resp = await http.get(url);
    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<ProductoModel> productos = new List();

    if (decodeData == null) return [];
    decodeData.forEach((id, producto) {
      final prodtem = ProductoModel.fromJson(producto);
      if (prodtem.titulo != null &&
          prodtem.sexo == "niño" &&
          prodtem.disponible == "disponible") {
        if (numero == 1) {
          prodtem.id = id;
          productos.add(prodtem);
        } else if (numero == 2 && prodtem.talla == "grande") {
          prodtem.id = id;
          productos.add(prodtem);
          print(prodtem.talla);
        } else if (numero == 3 && prodtem.talla == "mediana") {
          prodtem.id = id;
          productos.add(prodtem);
          print(prodtem.talla);
        } else if (numero == 4 && prodtem.talla == "chica") {
          prodtem.id = id;
          productos.add(prodtem);
          print(prodtem.talla);
        } else if (numero == 5 && prodtem.talla == "extra grande") {
          prodtem.id = id;
          productos.add(prodtem);
          print(prodtem.talla);
        }
      }
    });
    return productos;
  }

  Future<List<ProductoModel>> cargarProductoNina(numero) async {
    final url = '$_url/productos.json';
    final resp = await http.get(url);
    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<ProductoModel> productos = new List();

    if (decodeData == null) return [];
    decodeData.forEach((id, producto) {
      final prodtem = ProductoModel.fromJson(producto);
      if (prodtem.titulo != null &&
          prodtem.sexo == "niña" &&
          prodtem.disponible == "disponible") {
        if (numero == 1) {
          prodtem.id = id;
          productos.add(prodtem);
        } else if (numero == 2 && prodtem.talla == "grande") {
          prodtem.id = id;
          productos.add(prodtem);
          print(prodtem.talla);
        } else if (numero == 3 && prodtem.talla == "mediana") {
          prodtem.id = id;
          productos.add(prodtem);
          print(prodtem.talla);
        } else if (numero == 4 && prodtem.talla == "chica") {
          prodtem.id = id;
          productos.add(prodtem);
          print(prodtem.talla);
        } else if (numero == 5 && prodtem.talla == "extra grande") {
          prodtem.id = id;
          productos.add(prodtem);
          print(prodtem.talla);
        }
      }
    });
    return productos;
  }

  Future<int> borrarProducto(String id, String urll) async {
    String filePath = urll.replaceAll(
        new RegExp(
            r'https://firebasestorage.googleapis.com/v0/b/proyectogibranflutter.appspot.com/o/'),
        '');

    filePath = filePath.replaceAll(new RegExp(r'%2F'), '/');

    filePath = filePath.replaceAll(new RegExp(r'(\?alt).*'), '');

    StorageReference storageReferance = FirebaseStorage.instance.ref();

    storageReferance
        .child(filePath)
        .delete()
        .then((_) => print('Successfully deleted $filePath storage item'));

    final url = '$_url/productos/$id.json';
    final resp = await http.delete(url);
    print(json.decode(resp.body));

    return 1;
  }
}
