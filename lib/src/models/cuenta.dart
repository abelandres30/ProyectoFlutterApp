import 'dart:convert';

CuentaModel cuentaModelFromJson(String str) =>
    CuentaModel.fromJson(json.decode(str));

String cuentaModelToJson(CuentaModel data) => json.encode(data.toJson());

class CuentaModel {
  String nombre;
  String correo;
  int numero;
  int numeropedidos;
  CuentaModel({
    this.nombre = '',
    this.correo = '',
    this.numero = 0,
    this.numeropedidos = 0,
  });

  factory CuentaModel.fromJson(Map<String, dynamic> json) => new CuentaModel(
        nombre: json["nombre"],
        correo: json["correo"],
        numero: json["numero"],
        numeropedidos: json["numeropedidos"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "correo": correo,
        "numero": numero,
        "numeropedidos": numeropedidos,
      };
}
