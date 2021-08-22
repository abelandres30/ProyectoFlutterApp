import 'dart:convert';

ProductoPedidoModel productopedidoModelFromJson(String str) =>
    ProductoPedidoModel.fromJson(json.decode(str));

String pedidoModelToJson(ProductoPedidoModel data) =>
    json.encode(data.toJson());

class ProductoPedidoModel {
  String nombre;
  String talla;
  int precio;
  String sexo;
  String imagen;
  String llaveproducto;
  String tipo;
  int total;
  ProductoPedidoModel({
    this.nombre = '',
    this.talla = '',
    this.precio = 0,
    this.sexo = '',
    this.imagen = '',
    this.llaveproducto = '',
    this.tipo = '',
    this.total = 0,
  });

  factory ProductoPedidoModel.fromJson(Map<String, dynamic> json) =>
      new ProductoPedidoModel(
        nombre: json["nombre"],
        talla: json["talla"],
        precio: json["precio"],
        sexo: json["sexo"],
        imagen: json["imagen"],
        llaveproducto: json["llaveproducto"],
        tipo: json["tipo"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "talla": talla,
        "precio": precio,
        "imagen": imagen,
        "llaveproducto": llaveproducto,
        "sexo": sexo,
        "tipo": tipo,
        "total": total,
      };
}
