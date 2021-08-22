import 'dart:async';
import 'dart:convert';
import 'package:proyecto_gibran/src/models/lugares.dart';
import 'package:http/http.dart' as http;

class LugaresProvider {
  final String _url = 'https://proyectogibranflutter.firebaseio.com';
  
  Future<bool> crearLugar(LugaresModel lugar) async {
    final url = '$_url/lugares.json';

    final resp = await http.post(url, body: lugaresModelToJson(lugar));
    final decodeData = json.decode(resp.body);
    print(decodeData);
    return true;
  }

  Future<List<LugaresModel>> cargarLugar() async {
    final url = '$_url/lugares.json';
    final resp = await http.get(url);
    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<LugaresModel> lugares = new List();

    if (decodeData == null) return [];
    decodeData.forEach((id, lugar) {
      final prodtem = LugaresModel.fromJson(lugar);
      if (prodtem.nombre != null) {
        prodtem.id = id;
        lugares.add(prodtem);
      }
    });
    return lugares;
  }

  Future eliminarlugar(String id) async {
    final url = '$_url/lugares/$id.json';
    final resp = await http.delete(url);
    print(json.decode(resp.body));
    return 1;
  }
    Future<bool> editarProducto(LugaresModel lugar) async {
    final url = '$_url/lugares/${lugar.id}.json';
    final resp = await http.put(url, body: lugaresModelToJson(lugar));
    final decodeData = json.decode(resp.body);
    print(decodeData);
    return true;
  }
}
