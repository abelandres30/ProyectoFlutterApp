import 'dart:convert';

LugaresModel lugaresModelFromJson(String str) =>
    LugaresModel.fromJson(json.decode(str));

String lugaresModelToJson(LugaresModel data) => json.encode(data.toJson());

class LugaresModel {
  String id;
  String nombre;

  LugaresModel({
    this.id,
    this.nombre = '',
  });

  factory LugaresModel.fromJson(Map<String, dynamic> json) => new LugaresModel(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
      };
}
