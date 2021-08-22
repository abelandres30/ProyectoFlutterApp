import 'dart:async';
import 'dart:convert';
import 'package:proyecto_gibran/src/models/pedido_model.dart';
import 'package:http/http.dart' as http;

class PedidosProvider {
  final String _url = 'https://proyectogibranflutter.firebaseio.com';

  Future<List<PedidoModel>> cargarPedido() async {
    final url = '$_url/pedidos.json';
    final resp = await http.get(url);
    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<PedidoModel> pedidos = new List();

    if (decodeData == null) return [];
    decodeData.forEach((id, pedido) {
      final prodtem = PedidoModel.fromJson(pedido);
      if (prodtem.nombre != null) {
        prodtem.id = id;
        pedidos.add(prodtem);
      }
    });
    return pedidos;
  }

  Future eliminarpedido(String id) async {
    final url = '$_url/pedidos/$id.json';
    final resp = await http.delete(url);
    print(json.decode(resp.body));
    return 1;
  }
}
