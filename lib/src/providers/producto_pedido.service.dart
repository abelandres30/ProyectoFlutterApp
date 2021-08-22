import 'dart:async';
import 'dart:convert';
import 'package:proyecto_gibran/src/models/producto_pedido.dart';
import 'package:http/http.dart' as http;

class ProductoPedidoProvider {
  final String _url = 'https://proyectogibranflutter.firebaseio.com';

  Future<List<ProductoPedidoModel>> cargarProductoPedido(
      String nombre, String idpedido) async {
    final url = '$_url/productopedido.json';
    final resp = await http.get(url);
    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<ProductoPedidoModel> productos = new List();

    if (decodeData == null) return [];
    decodeData.forEach((id, productopedido) {
      // final prodtem = ProductoPedidoModel.fromJson(productopedido);
      // if (prodtem.cliente == nombre &&
      //     prodtem.cliente != null &&
      //     prodtem.llavepedido == idpedido) {
      //   prodtem.id = id;
      //   productos.add(prodtem);
      // }
    });

    return productos;
  }

  Future eliminarpedidos(String id) async {
    final url = '$_url/productopedido/$id.json';
    final resp = await http.delete(url);
    print(json.decode(resp.body));
    return 1;
  }

  Future eliminarproducto(String id) async {
    final url = '$_url/productos/$id.json';
    final resp = await http.delete(url);
    print(json.decode(resp.body));
    return 1;
  }
}
