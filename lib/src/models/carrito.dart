import 'dart:convert';

CarritoModel carritoModelFromJson(String str) =>
    CarritoModel.fromJson(json.decode(str));

String carritoModelToJson(CarritoModel data) => json.encode(data.toJson());

class CarritoModel {
  String id;
  // ignore: non_constant_identifier_names
  String Imagen;
  // ignore: non_constant_identifier_names
  String UsuarioCorreo;
  String genero;
  String llaveproducto;
  String talla;
  String tipo;
  String titulo;
  int total;
  int valor;
  String usuario;

  CarritoModel(
      {this.id,
      // ignore: non_constant_identifier_names
      this.Imagen = "",
      // ignore: non_constant_identifier_names
      this.UsuarioCorreo = "",
      this.genero = "",
      this.llaveproducto = "",
      this.talla = "",
      this.tipo = "",
      this.titulo = "",
      this.usuario = "",
      this.total = 0,
      this.valor = 0});

  factory CarritoModel.fromJson(Map<String, dynamic> json) => new CarritoModel(
        id: json["id"],
        // ignore: non_constant_identifier_names
        Imagen: json["Imagen"],
        // ignore: non_constant_identifier_names
        UsuarioCorreo: json["UsuarioCorreo"],
        genero: json["genero"],
        llaveproducto: json["llaveproducto"],
        talla: json["talla"],
        tipo: json["tipo"],
        titulo: json["titulo"],
        usuario: json["usuario"],
        total: json["total"],
        valor: json["valor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        // ignore: non_constant_identifier_names
        "Imagen": Imagen,
        // ignore: non_constant_identifier_names
        "UsuarioCorreo": UsuarioCorreo,
        "genero": genero,
        "llaveproducto": llaveproducto,
        "talla": talla,
        "tipo": tipo,
        "titulo": titulo,
        "total": total,
        "valor": valor,
        "usuario": usuario,
      };
}
