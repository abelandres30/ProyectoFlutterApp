import 'package:flutter/material.dart';
import 'package:proyecto_gibran/src/pages/Pedidos.dart';
import 'package:proyecto_gibran/src/pages/lugar.dart';
import 'package:proyecto_gibran/src/pages/PedidosDetalle.dart';
import 'package:proyecto_gibran/src/pages/producto.dart';
import 'CarritoDetalle.dart';
import 'SliderDezplazado.dart';
import 'lugares.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Negocio de ropa',
      initialRoute: 'menu',
      routes: {
        'producto': (BuildContext context) => ProductoPage(),
        'pedidos': (BuildContext context) => PedidoPage(),
        'pedido': (BuildContext context) => Clientes(),
        'lugar': (BuildContext context) => LugarPage(),
        'lugares': (BuildContext context) => Lugares(),
        'carritoDetalle': (BuildContext context) => CarritoDetallePage(),
      },
      home: Home(),
      theme: ThemeData(
          primaryColor: Color(0xFF2F008E), accentColor: Color(0xFFFDD303)),
    );
  }
}
