import 'dart:async';
import 'dart:convert';
import 'package:proyecto_gibran/src/models/carrito.dart';
import 'package:http/http.dart' as http;

class CarritoProvider {
  final String _url = 'https://proyectogibranflutter.firebaseio.com';

  Future<List<CarritoModel>> cargarCarrito() async {
    final url = '$_url/carrito.json';
    final resp = await http.get(url);
    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<CarritoModel> carrito2 = new List();
    if (decodeData == null) return [];
    decodeData.forEach((id, carrito) {
      bool entro = false;

      if (id != "ejemplo") {
        final prodtem = CarritoModel.fromJson(carrito);
        if (prodtem.titulo != null) {
          if (carrito2.length == 0) {
            prodtem.id = id;
            carrito2.add(prodtem);
          } else {
            carrito2.forEach((element) {
              if (element.UsuarioCorreo == prodtem.UsuarioCorreo) {
                entro = true;
              }
            });
            if (entro == false) {
              prodtem.id = id;
              carrito2.add(prodtem);
            }
          }
        }
      }
    });
    return carrito2;
  }

  Future eliminarcarrito(String id) async {
    final url = '$_url/carrito/$id.json';
    final resp = await http.delete(url);
    print(json.decode(resp.body));
    return 1;
  }
}
