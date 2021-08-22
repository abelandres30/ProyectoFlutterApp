import 'dart:async';
import 'dart:convert';
import 'package:proyecto_gibran/src/models/cuenta.dart';
import 'package:http/http.dart' as http;

class LugaresProvider {
  final String _url = 'https://proyectogibranflutter.firebaseio.com';

  Future<List<CuentaModel>> cargarCuenta() async {
    final url = '$_url/cuentas.json';
    final resp = await http.get(url);
    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<CuentaModel> cuentas = new List();

    if (decodeData == null) return [];
    decodeData.forEach((correo, cuenta) {
      final prodtem = CuentaModel.fromJson(cuenta);
      if (prodtem.nombre != null && prodtem.numeropedidos > 0) {
        prodtem.correo = correo;
        cuentas.add(prodtem);
      }
    });
    return cuentas;
  }

  Future eliminarcuenta(String id) async {
    final url = '$_url/cuentas.json';
    final resp = await http.delete(url);
    print(json.decode(resp.body));
    return 1;
  }
}
