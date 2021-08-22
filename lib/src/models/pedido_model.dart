import 'dart:convert';
import 'package:proyecto_gibran/src/models/producto_pedido.dart';

PedidoModel pedidoModelFromJson(String str) =>
    PedidoModel.fromJson(json.decode(str));

String pedidoModelToJson(PedidoModel data) => json.encode(data.toJson());
ProductoPedidoModel productopedido = new ProductoPedidoModel();

class PedidoModel {
  String id;
  String nombre;
  String lugarencuentro;
  String dia;
  String hora;
  int cantidadelementos;
  int total;
  int telefono;
  String correo;
  String estatus;
  List producto;

  PedidoModel({
    this.id,
    this.nombre = '',
    this.lugarencuentro = '',
    this.cantidadelementos = 0,
    this.dia = '',
    this.hora = '',
    this.total = 0,
    this.telefono = 0,
    this.correo = '',
    this.estatus = '',
    this.producto,
  });

  factory PedidoModel.fromJson(Map<String, dynamic> json) => new PedidoModel(
        id: json["id"],
        nombre: json["nombre"],
        lugarencuentro: json["lugarencuentro"],
        cantidadelementos: json["cantidadelementos"],
        dia: json["dia"],
        hora: json["hora"],
        total: json["total"],
        telefono: json["telefono"],
        correo: json["correo"],
        estatus: json["estatus"],
        producto: json["producto"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "lugarencuentro": lugarencuentro,
        "cantidadelementos": cantidadelementos,
        "dia": dia,
        "hora": hora,
        "total": total,
        "telefono": telefono,
        "correo": correo,
        "estatus": estatus,
        "producto": producto,
      };
}
