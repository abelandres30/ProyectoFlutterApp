// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

ProductoModel productoModelFromJson(String str) =>
    ProductoModel.fromJson(json.decode(str));

String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {
  String id;
  String titulo;
  String talla;
  String sexo;
  int valor;
  String disponible;
  String fotoUrl;
  int total;
  String tipo;

  ProductoModel({
    this.id,
    this.titulo = '',
    this.talla = '',
    this.sexo = '',
    this.valor = 0,
    this.disponible = "true",
    this.fotoUrl,
    this.total = 0,
    this.tipo = '',
  });

  factory ProductoModel.fromJson(Map<String, dynamic> json) =>
      new ProductoModel(
        // id         : json["id"],
        titulo: json["titulo"],
        talla: json["talla"],
        sexo: json["sexo"],
        valor: json["valor"],
        disponible: json["disponible"],
        fotoUrl: json["fotoUrl"],
        total: json["total"],
        tipo: json["tipo"],
      );

  Map<String, dynamic> toJson() => {
        // "id"         : id,
        "titulo": titulo,
        "talla": talla,
        "sexo": sexo,
        "valor": valor,
        "disponible": disponible,
        "fotoUrl": fotoUrl,
        "total": total,
        "tipo": tipo,
      };
}
