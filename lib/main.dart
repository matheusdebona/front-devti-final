import 'package:devti_front_final/pages/cadastro_cidade.dart';
import 'package:devti_front_final/pages/cadastro_cliente.dart';
import 'package:devti_front_final/pages/consulta_cidade.dart';
import 'package:devti_front_final/pages/consulta_cliente.dart';
import 'package:devti_front_final/pages/home.dart';
import 'package:devti_front_final/pages/page_cidade.dart';
import 'package:devti_front_final/pages/page_cliente.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Projeto DEVTI - Matheus de Bona',
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => const Home(),
        '/cidade': (context) => const PageCidade(),
        '/cidade/consulta': (context) => const ConsultaCidade(),
        '/cidade/cadastro': (context) => const CadastroCidade(),
        '/cliente': (context) => const PageCliente(),
        '/cliente/consulta': (context) => const ConsultaCliente(),
        '/cliente/cadastro': (context) => const CadastroCliente(),
      },
    );
  }
}
